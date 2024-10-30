void test(int a[]) {
    output(a[3]);
    return;
}

int main(void) {
    int a[10];
    a[3] = 10;
    test(a);
    return 0;
}
