
int main(void)
{
    report_start();
    base_test();
    leon_tsc(0x90000000);
    greth_test(0x80000e00);
    report_end();
}
