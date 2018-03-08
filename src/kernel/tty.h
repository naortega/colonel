#pragma once

#include <stddef.h>

void tty_init();
void tty_putchar(unsigned char c);
void tty_write(const char *data, size_t size);
void tty_write_s(const char *str);
