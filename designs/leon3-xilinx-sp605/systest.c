
main()

{
	report_start();


//	svgactrl_test(0x80000600, 1, 0, 0x40200000, -1, 0, 0);
	base_test();
/*
        greth_test(0x80000e00);
	spw_test(0x80100A00);
	spw_test(0x80100B00);
	spw_test(0x80100C00);
	svgactrl_test(0x80000600, 1, 0, 0x40200000, -1, 0, 0);
*/
        report_end();
}
