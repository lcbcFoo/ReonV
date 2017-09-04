
main()

{
	report_start();

	base_test();
        greth_test(0x80000d00);
//	spw_test(0x80000A00);
//	spw_test(0x80000B00);
//	spw_test(0x80000C00);
        report_end();
}
