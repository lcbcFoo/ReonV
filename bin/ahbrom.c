#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#ifdef WIN32
#include <winsock2.h>
#endif

main (argc, argv)
  int argc; char **argv;
{
  struct stat sbuf;
  unsigned char x[128];
  int i, j, res, fsize, abits, tmp, dbits, alow;
  FILE *fp, *wfp;
  char *suffix = "";
  char *xgeneric = "";

  if (argc < 3) exit(1);
  res = stat(argv[1], &sbuf);
  if (res < 0) exit(2);
  fsize = sbuf.st_size;
  fp = fopen(argv[1], "rb");
  wfp = fopen(argv[2], "w+");
  if (fp == NULL) exit(2);
  if (wfp == NULL) exit(2);
  dbits = 32;
  if (argc > 3) {
    dbits = atoi(argv[3]);
  }
  if (dbits != 32 && dbits != 64 && dbits != 128) exit(3);
  if (dbits == 64) suffix="64"; else if (dbits == 128) suffix="128";
  if (dbits != 32) xgeneric=";\n    wideonly: integer := 0";

  tmp = fsize; abits = 0;
  while (tmp) {tmp >>= 1; abits++;}
  tmp = (dbits >> 4); alow = 0;
  while (tmp) {tmp >>= 1; alow++; }
  printf("Creating %s : file size: %d bytes, address bits %d, data width %d\n", argv[2], fsize, abits, dbits);
  fprintf(wfp, "\n\
----------------------------------------------------------------------------\n\
--  This file is a part of the GRLIB VHDL IP LIBRARY\n\
--  Copyright (C) 2010 Aeroflex Gaisler\n\
----------------------------------------------------------------------------\n\
-- Entity:      ahbrom%s\n\
-- File:        ahbrom%s.vhd\n\
-- Author:      Jiri Gaisler - Gaisler Research\n\
-- Modified     Alen Bardizbanyan - Cobham Gaisler (pipelined impl.)\n\
-- Description: AHB rom. 0/1-waitstate read\n\
----------------------------------------------------------------------------\n\
library ieee;\n\
use ieee.std_logic_1164.all;\n\
library grlib;\n\
use grlib.amba.all;\n\
use grlib.stdlib.all;\n\
use grlib.devices.all;\n\
use grlib.config_types.all;\n\
use grlib.config.all;\n\
\n\
entity ahbrom%s is\n\
  generic (\n\
    hindex  : integer := 0;\n\
    haddr   : integer := 0;\n\
    hmask   : integer := 16#fff#;\n\
    pipe    : integer := 0;\n\
    tech    : integer := 0;\n\
    kbytes  : integer := 1%s);\n\
  port (\n\
    rst     : in  std_ulogic;\n\
    clk     : in  std_ulogic;\n\
    ahbsi   : in  ahb_slv_in_type;\n\
    ahbso   : out ahb_slv_out_type\n\
  );\n\
end;\n\
\n\
architecture rtl of ahbrom%s is\n\
constant abits : integer := %d;\n\
constant bytes : integer := %d;\n\
constant dbits : integer := %d;\n\
\n\
constant hconfig : ahb_config_type := (\n\
  0 => ahb_device_reg ( VENDOR_GAISLER, GAISLER_AHBROM, 0, 0, 0),\n\
  4 => ahb_membar(haddr, '1', '1', hmask), others => zero32);\n\
\n\
signal romdata : std_logic_vector(dbits-1 downto 0);\n\
signal romdatas : std_logic_vector(AHBDW-1 downto 0);\n\
signal addr : std_logic_vector(abits-1 downto 2);\n\
signal hsize : std_logic_vector(2 downto 0);\n\
signal romaddr : std_logic_vector(abits-1 downto log2(dbits/8));\n\
signal hready, active : std_ulogic;\n\
\n\
constant RESET_ALL : boolean := GRLIB_CONFIG_ARRAY(grlib_sync_reset_enable_all) = 1;\n\
\n\
begin\n\
\n\
  ahbso.hresp   <= \"00\";\n\
  ahbso.hsplit  <= (others => '0');\n\
  ahbso.hirq    <= (others => '0');\n\
  ahbso.hconfig <= hconfig;\n\
  ahbso.hindex  <= hindex;\n\
\n\
  reg : process (clk)\n\
  begin\n\
    if rising_edge(clk) then\n\
      addr <= ahbsi.haddr(abits-1 downto 2);\n\
      hsize <= ahbsi.hsize;\n\
      if RESET_ALL and rst='0' then addr <= (others => '0'); hsize <= \"000\"; end if;\n\
    end if;\n\
  end process;\n\
\n\
  p0 : if pipe = 0 generate\n\
    ahbso.hrdata  <= romdatas;\n\
    ahbso.hready  <= '1';\n\
    hready <= '0';\n\
  end generate;\n\
\n\
  active <= ahbsi.hsel(hindex) and ahbsi.htrans(1) and ahbsi.hready;\n\
  p1 : if pipe = 1 generate\n\
    ahbso.hready <= hready;\n\
    reg2 : process (clk)\n\
    begin\n\
      if rising_edge(clk) then\n\
        hready <= (not rst) or (not active) or (not(hready));\n\
        ahbso.hrdata <= romdatas;\n\
        if RESET_ALL and rst='0' then hready <= '1'; ahbso.hrdata <= (others => '0'); end if;\n\
      end if;\n\
    end process;\n\
  end generate;\n\
\n\
  romaddr <= addr(abits-1 downto log2(dbits/8));\n\
", suffix, suffix, suffix, xgeneric, suffix, abits, fsize, dbits);
  if (dbits < 64) {
          fprintf(wfp, "  romdatas <= ahbdrivedata(romdata);\n");
  } else {
          fprintf(wfp, "\
  romdatas <= ahbdrivedata(romdata) when wideonly/=0 or CORE_ACDM=1 else \n\
    ahbselectdata(ahbdrivedata(romdata),addr(4 downto 2),hsize);\n\
");
  }
  fprintf(wfp, "\n\
  comb : process (romaddr)\n\
  begin\n\
    case conv_integer(romaddr) is\n\
");
  i = 0;
  while (!feof(fp)) {
    memset(x,0,dbits/8);
    fread(x, 1, dbits/8, fp);
    fprintf(wfp, "    when 16#%05X# => romdata <= X\"", i++);
    for (j=0; j<dbits/8; j++)
            fprintf(wfp, "%02x",x[j]);
    fprintf(wfp,"\";\n");
  }
  fprintf(wfp, "\
    when others => romdata <= (others => '-');\n\
    end case;\n\
  end process;\n\
  -- pragma translate_off\n\
  bootmsg : report_version\n\
  generic map (\"ahbrom%s%s\" & tost(hindex) &\n\
  \": %d-bit AHB ROM Module,  \" & tost(bytes/(dbits/8)) & \" words, \" & tost(abits-log2(dbits/8)) & \" address bits\" );\n\
  -- pragma translate_on\n\
  end;\n\
",suffix,(dbits>32)?"_":"",dbits);

 fclose (wfp);
 fclose (fp);
 return(0);
 exit(0);
}
