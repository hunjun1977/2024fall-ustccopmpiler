loongarch64-unknown-linux-gnu-gcc -static test.s -o test
qemu-loongarch64 -g 1234 test &
loongarch64-unknown-linux-gnu-gdb --quiet
file test
target remote localhost:1234