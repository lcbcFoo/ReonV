/*
 * Copyright (c) 2011 Aeroflex Gaisler
 *
 * BSD license:
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */


/*******************************************************************************
 *
 *                        REONV - CONSOLE SUPPORT
 *
 *  This is a modified version of some files on leon3 compiler bcc 2.0.2 source
 * code, avaiable with GPL license on Aeroflex Gaisler website.
 *
 *  Console via UART is not supported yet on ReonV, this code may be used in
 * future only.
 *
 *******************************************************************************
*/

#include <stdlib.h>
#include <ctype.h>
#include <stdarg.h>


/*
 *  The following defines the bits in the UART Control Registers.
 *
 */

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


typedef struct
{
  volatile unsigned int data;
  volatile unsigned int status;
  volatile unsigned int ctrl;
  volatile unsigned int scaler;
} LEON23_APBUART_Regs_Map;
extern volatile LEON23_APBUART_Regs_Map *leon23_uarts[2];	/* in console.c */


typedef struct amba_apb_device
{
  unsigned int start, irq;
} amba_apb_device;


static size_t
lo_strnlen (const char *s, size_t count)
{
  const char *sc;

  for (sc = s; count-- && *sc != '\0'; ++sc)
    /* nothing */ ;
  return sc - s;
}

static int
lo_vsnprintf (char *buf, size_t size, const char *fmt, va_list args)
{
  int len;
  unsigned long long num;
  int i, j, n;
  char *str, *end, c;
  const char *s;
  int flags;
  int field_width;
  int precision;
  int qualifier;
  int filler;

  str = buf;
  end = buf + size - 1;

  if (end < buf - 1)
    {
      end = ((void *) -1);
      size = end - buf + 1;
    }

  for (; *fmt; ++fmt)
    {
      if (*fmt != '%')
	{
	  if (*fmt == '\n')
	    {
	      if (str <= end)
		{
		  *str = '\r';
		}
	      str++;
	    }
	  if (str <= end)
	    *str = *fmt;
	  ++str;
	  continue;
	}

      /* process flags */
      flags = 0;
      /* get field width */
      field_width = 0;
      /* get the precision */
      precision = -1;
      /* get the conversion qualifier */
      qualifier = 'l';
      filler = ' ';

      ++fmt;

      if (*fmt == '0')
	{
	  filler = '0';
	  ++fmt;
	}

      while (isdigit (*fmt))
	{
	  field_width = field_width * 10 + ((*fmt) - '0');
	  ++fmt;
	}

      /* default base */
      switch (*fmt)
	{
	case 'c':
	  c = (unsigned char) va_arg (args, int);
	  if (str <= end)
	    *str = c;
	  ++str;
	  while (--field_width > 0)
	    {
	      if (str <= end)
		*str = ' ';
	      ++str;
	    }
	  continue;

	case 's':
	  s = va_arg (args, char *);
	  if (!s)
	    s = "<NULL>";

	  len = lo_strnlen (s, precision);

	  for (i = 0; i < len; ++i)
	    {
	      if (str <= end)
		*str = *s;
	      ++str;
	      ++s;
	    }
	  while (len < field_width--)
	    {
	      if (str <= end)
		*str = ' ';
	      ++str;
	    }
	  continue;


	case '%':
	  if (str <= end)
	    *str = '%';
	  ++str;
	  continue;

	case 'x':
	  break;
	case 'd':
	  break;

	default:
	  if (str <= end)
	    *str = '%';
	  ++str;
	  if (*fmt)
	    {
	      if (str <= end)
		*str = *fmt;
	      ++str;
	    }
	  else
	    {
	      --fmt;
	    }
	  continue;
	}
      num = va_arg (args, unsigned long);
      if (*fmt == 'd')
	{
	  j = 0;
	  while (num && str <= end)
	    {
	      *str = (num % 10) + '0';
	      num = num / 10;
	      ++str;
	      j++;
	    }
	  /* flip */
	  for (i = 0; i < (j / 2); i++)
	    {
	      n = str[(-j) + i];
	      str[(-j) + i] = str[-(i + 1)];
	      str[-(i + 1)] = n;
	    }
	  /* shift */
	  if (field_width > j)
	    {
	      i = field_width - j;
	      for (n = 1; n <= j; n++)
		{
		  if (str + i - n <= end)
		    {
		      str[i - n] = str[-n];
		    }
		}
	      for (i--; i >= 0; i--)
		{
		  str[i - j] = filler;
		}
	      str += field_width - j;
	      j = 1;
	    }
	}
      else
	{
	  for (j = 0, i = 0; i < 8 && str <= end; i++)
	    {
	      if ((n =
		   ((unsigned long) (num & (0xf0000000ul >> (i * 4)))) >>
		   ((7 - i) * 4)) || j != 0)
		{
		  if (n >= 10)
		    n += 'a' - 10;
		  else
		    n += '0';
		  *str = n;
		  ++str;
		  j++;
		}
	    }

	  /* shift */
	  if (field_width > j)
	    {
	      i = field_width - j;
	      for (n = 1; n <= j; n++)
		{
		  if (str + i - n <= end)
		    {
		      str[i - n] = str[-n];
		    }
		}
	      for (i--; i >= 0; i--)
		{
		  str[i - j] = filler;
		}
	      str += field_width - j;
	      j = 1;
	    }


	}

      if (j == 0 && str <= end)
	{
	  *str = '0';
	  ++str;
	}
    }
  if (str <= end)
    *str = '\0';
  else if (size > 0)
    /* don't write out a null byte if the buf size is zero */
    *end = '\0';
  /* the trailing null byte doesn't count towards the total
   * ++str;
   */
  return str - buf;
}

/**
 * lo_vsprintf - Format a string and place it in a buffer
 * @buf: The buffer to place the result into
 * @fmt: The format string to use
 * @args: Arguments for the format string
 *
 * Call this function if you are already dealing with a va_list.
 * You probably want lo_sprintf instead.
 */
static int
lo_vsprintf (char *buf, const char *fmt, va_list args)
{
  return lo_vsnprintf (buf, 0xFFFFFFFFUL, fmt, args);
}


int
dbgleon_sprintf (char *buf, size_t size, const char *fmt, ...)
{
  va_list args;
  int printed_len;

  va_start (args, fmt);
  printed_len = lo_vsnprintf (buf, size, fmt, args);
  va_end (args);
  return printed_len;
}

#define UART_TIMEOUT 100000
static LEON23_APBUART_Regs_Map *uart_regs = 0;
//int *console = (int *) 0x80000100;
int
dbgleon_printf (const char *fmt, ...)
{
  unsigned int i, loops, ch;
  amba_apb_device apbdevs[1];
  va_list args;
  int printed_len;
  char printk_buf[1024];
  char *p = printk_buf;

  /* Emit the output into the temporary buffer */
  va_start (args, fmt);
  printed_len = lo_vsnprintf (printk_buf, sizeof (printk_buf), fmt, args);
  va_end (args);


    uart_regs = (LEON23_APBUART_Regs_Map*) 0x80000100;
	if (uart_regs){
	    while (printed_len-- != 0){
    		ch = *p++;
    		if (uart_regs){
    		    loops = 0;

                while (!(uart_regs->status & LEON_REG_UART_STATUS_THE) && (loops < UART_TIMEOUT))
    		          loops++;

                uart_regs->data = ch;
    		    loops = 0;
    		    while (!(uart_regs->status & LEON_REG_UART_STATUS_TSE) && (loops < UART_TIMEOUT))
    		        loops++;
    		  }
	      }
	  }
  //---------------------
}
