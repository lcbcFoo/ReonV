
main()

{
	report_start();

	base_test();
        greth_test(0x80000b00);
        greth_test(0x80000c00);
        report_end();
}
