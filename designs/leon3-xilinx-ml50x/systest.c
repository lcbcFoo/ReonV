
main()

{
	report_start();

	base_test();

	greth_test(0x80000b00);

	/* i2cmst_test(0x80000c00); */

	report_end();
}
