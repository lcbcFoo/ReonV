#ifndef POSIXC_H_INCLUDED
#define POSIXC_H_INCLUDED

typedef struct
{
  volatile unsigned int data;
  volatile unsigned int status;
  volatile unsigned int ctrl;
  volatile unsigned int scaler;
} LEON23_APBUART_Regs_Map;


#ifndef POSIC_C

extern char* out_mem;
extern char* console_buffer;
extern LEON23_APBUART_Regs_Map *uart_regs;

#endif


int send_uart (char *fmt, unsigned int len);

// Minimal implementationof memcpy
void *memcpy(void *dest, const void *src, unsigned int n);

// Startup code
void _init_reonv();

// Exit application
void _exit( int status );

// Repositions the offset of memory section (no file descriptor implemented)
int _lseek( int fd, int offset, int whence );

// Read from output memory section (no file descriptor implemented)
int _read( int fd, char *buffer, int len );

// Write to output memory section (no file descriptor implemented)
int _write( int fd, char *buffer, int len );

// Open a file (no file descriptor implemented)
int _open( const char *path, int flags, int mode );

// Close fd (no file descriptor implemented)
int _close( int fd );

// Allocate space on heap
void* _sbrk( int incr );

#endif //POSIXC_H_INCLUDED
