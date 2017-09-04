
main()

{
	report_start();
        
//	svgactrl_test(0x80000600, 1, 0, 0x40200000, -1, 0, 0);

        base_test();

	gpio_test(0x80000900);
	gpio_test(0x80000a00); 

        report_end();
}
