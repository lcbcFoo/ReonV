// #include <stdio.h>
// #include <sys/types.h>
// #include <sys/stat.h>
// #include <errno.h>
#include <sys/types.h>
#include <unistd.h>
#include "reonv.h"

static char* heap = (char*) HEAP_START;
static char* out_mem = (char*)OUT_MEM_BEGIN;

// Currently only reads/writes data from output section of memory

#define DREADY 1
#define TREADY 4

volatile char *console = (char *) 0x80000100;
volatile int *uart_shifter = (int *) 0x80000104;


// extern void
// outbyte (int c)
// {
//   volatile int *rxstat;
//   volatile int *rxadata;
//   int rxmask;
//   while ((console[1] & TREADY) == 0);
//   console[0] = (0x0ff & c);
//   if (c == '\n')
//     {
//       while ((console[1] & TREADY) == 0);
//       console[0] = (int) '\r';
//     }
// }
//
// int
// inbyte (void)
// {
//   if (!console)
//     return (0);
//   while (!(console[1] & DREADY));
//   return console[0];
// }


// exit application
void _exit_c( int status ) {
	__asm("ebreak");
}

// Repositions the offset of the open file associated with the file descriptor fd to the argument offset.
int _lseek_c( int fd, int offset, int whence ) {

    if(whence == SEEK_SET)
        out_mem = (char*) (OUT_MEM_BEGIN + offset);
   else if(whence == SEEK_CUR)
       out_mem = (char*) (out_mem + offset);
   else if(whence == SEEK_END)
       out_mem = (char*) (OUT_MEM_END + offset);
   else
       return -1;

    if(out_mem < (char*) OUT_MEM_BEGIN)
        return -1;
    else if(out_mem > (char*) OUT_MEM_END)
        return -1;

	return out_mem - (char*) OUT_MEM_BEGIN;
}


// Read from a file descriptor.
int _read_c( int fd, char *buffer, int len ) {
	volatile register int r0 asm("t0") = fd;
	volatile register char* r1 asm("t1") = buffer;
	volatile register int r2 asm("t2") = len;

    int i;
    for(i = 0; (i < len) && (&out_mem[i] < (char*)OUT_MEM_END); i++){
        buffer[i] = out_mem[i];
    }

    out_mem += i;
    return i;
}

// Write to a file descriptor.
int _write_c( int fd, char *buffer, int len ) {
	volatile register int r0 asm("t0") = fd;
	volatile register char* r1 asm("t1") = buffer;
	volatile register int r2 asm("t2") = len;

    int i;
	for(i = 0; (i < len) && (&out_mem[i] < (char*)OUT_MEM_END); i++){
		out_mem[i] = buffer[i];
	}

    out_mem += i;
	return i;
}

// Open a file.
int _open_c( const char *path, int flags, int mode ) {
	volatile register const char* r0 asm("t0") = path;
	volatile register int r1 asm("t1") = flags;
	volatile register int r2 asm("t2") = mode;


	return 0;
}

// Close a file descriptor.
extern  int _close_c( int fd ) {
	volatile register int r0 asm("t0") = fd;

	return 0;
}

// Allocate space on heap
extern void* _sbrk_c( int incr ) {
	void* addr = (void*) heap;
	heap += incr;
	return addr;
}
