#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <errno.h>
#include "reonv.h"

#undef errno

extern int errno;
char *__env[1] = { 0 };
char **environ = __env;

#define SYS_RESTART      0x0
#define SYS_EXIT         0x1
#define SYS_FORK         0x2
#define SYS_READ         0x3
#define SYS_WRITE        0x4
#define SYS_OPEN         0x5
#define SYS_CLOSE        0x6
#define SYS_WAIT         0x7
#define SYS_CREAT        0x8
#define SYS_LINK         0x9
#define SYS_UNLINK       0xA
#define SYS_EXECVE       0xB
#define SYS_CHDIR        0xC
#define SYS_MKNOD        0xE
#define SYS_CHMOD        0xF
#define SYS_LCHOW        0x10
#define SYS_STAT         0x12
#define SYS_LSEEK        0x13
#define SYS_GETPID       0x14
#define SYS_ALARM        0x1B
#define SYS_FSTAT        0x6C
#define SYS_KILL         0x25
#define SYS_TIMES        0x2B
#define SYS_BRK          0x2D
#define SYS_GETTIMEOFDAY 0x4E
#define SYS_SLEEP        0xA2
#define SYS_ACCESS       0x21


static unsigned *out_mem = (unsigned *)OUT_MEM_BEGIN;
static unsigned current_position = 0;

// exit application
extern  void _exit_c( int status ) {
	__asm("ebreak");
}

// Read from a file descriptor.
extern  int _read_c( int fd, char *buffer, int len ) {
	volatile register int r0 asm("t0") = fd;
	volatile register char* r1 asm("t1") = buffer;
	volatile register int r2 asm("t2") = len;
	volatile register unsigned r7 asm("a0") = SYS_READ;
	return r0;
}

// Write to a file descriptor.
extern  int _write_c( int fd, char *buffer, int len ) {
	volatile register int r0 asm("t0") = fd;
	volatile register char* r1 asm("t1") = buffer;
	volatile register int r2 asm("t2") = len;
	volatile register unsigned r7 asm("a0") = SYS_WRITE;
	return r0;
}

// Open a file.
extern  int _open_c( const char *path, int flags, int mode ) {
	volatile register const char* r0 asm("t0") = path;
	volatile register int r1 asm("t1") = flags;
	volatile register int r2 asm("t2") = mode;
	volatile register unsigned r7 asm("a0") = SYS_OPEN;
	return *(int*) r0;
}

// Close a file descriptor.
extern  int _close_c( int fd ) {
	volatile register int r0 asm("t0") = fd;
	volatile register unsigned r7 asm("a0") = SYS_CLOSE;
	return r0;
}
