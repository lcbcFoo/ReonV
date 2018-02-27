#include <stdlib.h>
#include <assert.h>
#include <stdio.h>


#define LEON_REG_UART_CONTROL_RTD  0x000000FF /* RX/TX data */

/*
 *  The following defines the bits in the LEON UART Status Register.
 */

#define LEON_REG_UART_STATUS_DR   0x00000001 /* Data Ready */
#define LEON_REG_UART_STATUS_TSE  0x00000002 /* TX Send Register Empty */
#define LEON_REG_UART_STATUS_THE  0x00000004 /* TX Hold Register Empty */
#define LEON_REG_UART_STATUS_BR   0x00000008 /* Break Error */
#define LEON_REG_UART_STATUS_OE   0x00000010 /* RX Overrun Error */
#define LEON_REG_UART_STATUS_PE   0x00000020 /* RX Parity Error */
#define LEON_REG_UART_STATUS_FE   0x00000040 /* RX Framing Error */
#define LEON_REG_UART_STATUS_TF   0x00000200 /* FIFO Full */
#define LEON_REG_UART_STATUS_ERR  0x00000078 /* Error Mask */

/*
 *  The following defines the bits in the LEON UART Control Register.
 */

#define LEON_REG_UART_CTRL_RE     0x00000001 /* Receiver enable */
#define LEON_REG_UART_CTRL_TE     0x00000002 /* Transmitter enable */
#define LEON_REG_UART_CTRL_RI     0x00000004 /* Receiver interrupt enable */
#define LEON_REG_UART_CTRL_TI     0x00000008 /* Transmitter interrupt enable */
#define LEON_REG_UART_CTRL_PS     0x00000010 /* Parity select */
#define LEON_REG_UART_CTRL_PE     0x00000020 /* Parity enable */
#define LEON_REG_UART_CTRL_FL     0x00000040 /* Flow control enable */
#define LEON_REG_UART_CTRL_LB     0x00000080 /* Loop Back enable */
#define LEON_REG_UART_CTRL_DB     0x00000800 /* Debug FIFO enable */
#define LEON_REG_UART_CTRL_SI     0x00004000 /* TX shift register empty IRQ enable */
#define LEON_REG_UART_CTRL_FA     0x80000000 /* FIFO Available */
#define LEON_REG_UART_CTRL_FA_BIT 31

#define APBUART_CTRL_RE 0x1
#define APBUART_CTRL_TE 0x2
#define APBUART_CTRL_RI 0x4
#define APBUART_CTRL_TI 0x8
#define APBUART_CTRL_PS 0x10
#define APBUART_CTRL_PE 0x20
#define APBUART_CTRL_FL 0x40
#define APBUART_CTRL_LB 0x80
#define APBUART_CTRL_EC 0x100
#define APBUART_CTRL_TF 0x200
#define APBUART_CTRL_RF 0x400
#define APBUART_CTRL_BI 0x1000
#define APBUART_CTRL_DI 0x2000
#define APBUART_CTRL_FA 0x80000000

#define APBUART_STATUS_DR 0x1
#define APBUART_STATUS_TS 0x2
#define APBUART_STATUS_TE 0x4
#define APBUART_STATUS_BR 0x8
#define APBUART_STATUS_OV 0x10
#define APBUART_STATUS_PE 0x20
#define APBUART_STATUS_FE 0x40
#define APBUART_STATUS_ERR 0x78
#define APBUART_STATUS_TH 0x80
#define APBUART_STATUS_RH 0x100
#define APBUART_STATUS_TF 0x200
#define APBUART_STATUS_RF 0x400




/* APB UART */
typedef struct apbuart_regs {
  volatile unsigned int data;
  volatile unsigned int status;
  volatile unsigned int ctrl;
  volatile unsigned int scaler;
} apbuart_regs;

struct apbuart_regs *uart_regs = (struct apbuart_regs*) 0x80000100;

/* Before UART driver has registered (or when no UART is available), calls to
 * printk that gets to bsp_out_char() will be filling data into the
 * pre_printk_dbgbuf[] buffer, hopefully the buffer can help debugging the
 * early BSP boot.. At least the last printk() will be caught.
 */
static char pre_printk_dbgbuf[32] = {0};
static int pre_printk_pos = 0;

void apbuart_outbyte_polled(unsigned char ch, int do_cr_on_newline, int wait_sent){
send:
    while ( (uart_regs->status & APBUART_STATUS_TE) == 0 ) {
        /* Lower bus utilization while waiting for UART */
        __asm__ volatile ("nop"::); __asm__ volatile ("nop"::);
        __asm__ volatile ("nop"::); __asm__ volatile ("nop"::);
        __asm__ volatile ("nop"::); __asm__ volatile ("nop"::);
        __asm__ volatile ("nop"::); __asm__ volatile ("nop"::);
    }

    if ((ch == '\n') && do_cr_on_newline) {
        uart_regs->data = (unsigned int) '\r';
        do_cr_on_newline = 0;
        goto send;
    }
    uart_regs->data = (unsigned int) ch;

    /* Wait until the character has been sent? */
    if (wait_sent) {
        while ((uart_regs->status & APBUART_STATUS_TE) == 0);
    }
}

void apbuart_write_polled(const char *buf, size_t len)
{
    size_t nwrite = 0;

    while (nwrite < len) {
        apbuart_outbyte_polled(*buf++, 0, 1);
        nwrite++;
    }
}


void bsp_debug_uart_init(void)
{
  //   int i;
  //   struct ambapp_dev *adev;
  //   struct ambapp_apb_info *apb;
  //
  //   /* Update uart_regs_index to index used as debug console. Let user
  //    * select Debug console by setting uart_regs_index. If the BSP is to
  //    * provide the default UART (uart_regs_index==0):
  //    *   non-MP: APBUART[0] is debug console
  //    *   MP: LEON CPU index select UART
  //    */
  //   if (uart_regs_index == 0) {
  //       uart_regs_index = 0;
  //   } else {
  //       uart_regs_index--; /* User selected dbg-console */
  //   }
  //
  // /* Find APBUART core for System Debug Console */
  //   i = uart_regs_index;
  //   adev = (void *)ambapp_for_each(&ambapp_plb, (OPTIONS_ALL|OPTIONS_APB_SLVS),
  //                                VENDOR_GAISLER, GAISLER_APBUART,
  //                                ambapp_find_by_idx, (void *)&i);
  //   if (adev) {
  //       /* Found a matching debug console, initialize debug uart if present
  //        * for printk
  //        */
  //       apb = (struct ambapp_apb_info *)adev->devinfo;
  //       uart_regs = (struct apbuart_regs *)apb->start;
        uart_regs->ctrl |= APBUART_CTRL_RE | APBUART_CTRL_TE;
        uart_regs->status = 0;
    //}
}
