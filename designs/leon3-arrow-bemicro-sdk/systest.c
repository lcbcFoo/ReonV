
main()
{
	report_start();

	base_test();
        
        /* 
           Loopback test of first SPI controller.
           Connected to temp sensor on board
        */
        spictrl_test(0x80000400, 1);

        /*
          The with ext. device of second SPI controller.
          Remove this function call if the 2:nd SPICTRL
          core is removed from design.
        */
	spictrl_test(0x80000500, 2);

        /* Ethernet core test */
	greth_test(0x80000600);

	report_end();
}
