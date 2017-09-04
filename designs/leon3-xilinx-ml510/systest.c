
main()

{
	report_start();

        /* base_test() with adjusted addresses */
        leon3_test(1, 0xc0000200, 0);
	irqtest(0xc0000200);
	gptimer_test(0xc0000300, 8);
	apbuart_test(0xc0000100);

	report_end();
}
