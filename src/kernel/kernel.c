#include <kernel/tty.h>

void kernel_main() {
	tty_init();
	tty_write_s("Hello from the kernel!");
}
