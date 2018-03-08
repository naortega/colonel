#include <stddef.h>
#include <stdint.h>

#include <kernel/tty.h>

#include "vga.h"

#define VGA_WIDTH 80
#define VGA_HEIGHT 25
#define VGA_MEMORY 0xb8000


static size_t tty_row;
static size_t tty_col;
static uint8_t tty_color;
static uint16_t *tty_buffer;

void tty_init() {
	tty_row = 0;
	tty_col = 0;
	tty_color = vga_entry_color(VGA_COLOR_LIGHT_GREY, VGA_COLOR_BLACK);
	tty_buffer = (uint16_t*) VGA_MEMORY;
	for(size_t y = 0; y < VGA_HEIGHT; ++y)
	{
		for(size_t x = 0; x < VGA_WIDTH; ++x)
		{
			const size_t index = GET_INDEX(x, y);
			tty_buffer[index] = vga_entry(' ', tty_color);
		}
	}
}

void tty_setcolor(uint8_t color) {
	tty_color = color;
}

void tty_putentryat(unsigned char c, uint8_t color, size_t x, size_t y) {
	const size_t index = GET_INDEX(x, y);
	tty_buffer[index] = vga_entry(c, color);
}

void tty_scroll_down() {
	// clear first line
	for(size_t x = 0; x < VGA_WIDTH; ++x)
	{
		const size_t i = GET_INDEX(x, 0);
		tty_buffer[i] = vga_entry(' ', tty_color);
	}

	// scroll text
	for(size_t y = 1; y < VGA_HEIGHT; ++y)
	{
		for(size_t x = 0; x < VGA_WIDTH; ++x)
		{
			const size_t srci = GET_INDEX(x, y);
			const size_t dsti = GET_INDEX(x, y - 1);
			tty_buffer[dsti] = tty_buffer[srci];
		}
	}
}

void tty_putchar(unsigned char c) {
	tty_putentryat(c, tty_color, tty_col, tty_row);
	if(++tty_col == VGA_WIDTH)
	{
		tty_col = 0;
		if(tty_row + 1 == VGA_HEIGHT)
			tty_scroll_down();
		else
			tty_row++;
	}
}

void tty_write(const char *data, size_t size) {
	for(size_t i = 0; i < size; ++i)
		tty_putchar(data[i]);
}

void tty_write_s(const char *str) {
	size_t len = 0;
	while(str[len])
		len++;
	tty_write(str, len);
}
