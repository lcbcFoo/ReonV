
int main(void)
{
	report_start();

	base_test();

	greth_test(0x80000b00);

	report_end();
}
