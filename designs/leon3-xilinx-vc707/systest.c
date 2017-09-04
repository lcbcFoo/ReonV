
main()

{

/*
unsigned long* const memptr = (unsigned long*) 0x40000000;
unsigned long memory;
*memptr = 0x87654321;
memory = *memptr; 
*/

  report_start();
  base_test();
  /*greth_test(0x800c0000);*/
  report_end();
}
