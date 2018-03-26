#ifndef REONV_H_INCLUDED
#define REONV_H_INCLUDED

/* Reonv constants, most of them copied from GRLIB manual or BCC compiler
 * source code
 */

#define RAM_START               0x40000000
#define RAM_SIZE                0x08000000
#define SP_START                0x43FFFFF0
#define HEAP_START              0x43000000
#define OUT_MEM_BEGIN           0x44000000
#define OUT_MEM_END             0x45000000
#define CONSOLE_BUFFER_SIZE     1024

/* Following defines were removed from Leon3 compiler bcc */
#define LEON_REG_UART_CONTROL_RTD  0x000000FF	/* RX/TX data */

/*
 *  The following defines the bits in the LEON UART Status Registers.
 */

#define LEON_REG_UART_STATUS_DR   0x00000001	/* Data Ready */
#define LEON_REG_UART_STATUS_TSE  0x00000002	/* TX Send Register Empty */
#define LEON_REG_UART_STATUS_THE  0x00000004	/* TX Hold Register Empty */
#define LEON_REG_UART_STATUS_BR   0x00000008	/* Break Error */
#define LEON_REG_UART_STATUS_OE   0x00000010	/* RX Overrun Error */
#define LEON_REG_UART_STATUS_PE   0x00000020	/* RX Parity Error */
#define LEON_REG_UART_STATUS_FE   0x00000040	/* RX Framing Error */
#define LEON_REG_UART_STATUS_ERR  0x00000078	/* Error Mask */


/*
 *  The following defines the bits in the LEON UART Status Registers.
 */

#define LEON_REG_UART_CTRL_RE     0x00000001	/* Receiver enable */
#define LEON_REG_UART_CTRL_TE     0x00000002	/* Transmitter enable */
#define LEON_REG_UART_CTRL_RI     0x00000004	/* Receiver interrupt enable */
#define LEON_REG_UART_CTRL_TI     0x00000008	/* Transmitter interrupt enable */
#define LEON_REG_UART_CTRL_PS     0x00000010	/* Parity select */
#define LEON_REG_UART_CTRL_PE     0x00000020	/* Parity enable */
#define LEON_REG_UART_CTRL_FL     0x00000040	/* Flow control enable */
#define LEON_REG_UART_CTRL_LB     0x00000080	/* Loop Back enable */

#define UART_TIMEOUT 5000                       /* Timeout for TX */

#endif //REONV_H_INCLUDED
