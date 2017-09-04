/*
 * Entity:      ahbfile
 * File:        ahbfile.vhd
 * Author:      Martin Aberg - Cobham Gaisler AB
 * Description: File I/O debug communication link, using AHBUART protocol
 *
 * This file contains the C language part of ahbfile.
 *
 * Comple-time options:
 * - AHBFILE_NAME: name of file to operate on. May work on pseudoterminal file,
 *   FIFO, etc.
 *   Example: "myfile"
 *   Default: "slave_sim"
 *
 * - AHBFILE_DEBUG: Set to nonzero to indicate progress on stdout on each
 *   AHBFILE_DEBUGth get/put operation.
 *   Example: 0
 *   Default: 64
 */

#include <stdint.h>
#include <stdio.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <errno.h>
#include <fcntl.h>
#include <unistd.h>

#ifndef AHBFILE_DEBUG
#define AHBFILE_DEBUG 64
#endif

#ifndef AHBFILE_NAME
#define AHBFILE_NAME "slave_sim"
#endif

static int putfd;
static int getfd;

/* Open AHBFILE_NAME twice: for non-blocking read and for blocking write. */
int ahbfile_init(void)
{
  int fd;

  printf("%s: Connecting to file `%s`.\n", __func__, AHBFILE_NAME);

  fd = open(AHBFILE_NAME, O_RDONLY | O_NONBLOCK);
  if (-1 == fd) {
    printf("%s: Error opening file `%s`.\n", __func__, AHBFILE_NAME);
    return -1;
  }
  getfd = fd;

  fd = open(AHBFILE_NAME, O_WRONLY);
  if (-1 == fd) {
    printf("%s: Error opening file `%s`.\n", __func__, AHBFILE_NAME);
    return -1;
  }
  putfd = fd;

  return fd;
}

/* Output a dot on stdout every AHBFILE_DEBUG time the function is called. */
static void progress(void);

/* Non-blocking read of one byte. Returns byte value or -1 if no data available. */
int ahbfile_getbyte(void)
{
/* It is important that the getbyte function is non-blocking because it would
 * otherwise block the simulation when no read data is available. Going into
 * the kernel and poll each simulated clock cycle is a bit nasty. Start
 * simulation with time(1) to see how much it degrades performance. Maintaining
 * a read buffer is an alternative.
 */
  ssize_t n;
  uint8_t buf;

  n = read(getfd, &buf, 1);
  if (1 == n) {
    progress();
    return buf;
  } else {
    return -1;
  }
}

int ahbfile_putbyte(int value)
{
  ssize_t n;
  uint8_t buf = value;

  n = write(putfd, &buf, 1);
  if (1 != n) {
    perror(__func__);
    return -1;
  }
  progress();
  return 0;
}

static void progress(void)
{
#if AHBFILE_DEBUG
  static unsigned int cnt = 0;
  cnt++;
  if (0 == cnt % AHBFILE_DEBUG) {
    putchar('.');
    fflush(stdout);
  }
#endif
}

