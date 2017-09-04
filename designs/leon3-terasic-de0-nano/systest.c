
main()

{
	report_start();
        
        base_test();

	gpio_test(0x80000900);
	gpio_test(0x80000a00); 

        report_end();
}
