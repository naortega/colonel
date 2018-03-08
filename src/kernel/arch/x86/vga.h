#pragma once

#include <stdint.h>
#define GET_INDEX(x, y)  y * VGA_WIDTH + x

enum vga_color {
	VGA_COLOR_BLACK             = 0x0,
	VGA_COLOR_BLUE              = 0x1,
	VGA_COLOR_GREEN             = 0x2,
	VGA_COLOR_CYAN              = 0x3,
	VGA_COLOR_RED               = 0x4,
	VGA_COLOR_MAGENTA           = 0x5,
	VGA_COLOR_BROWN             = 0x6,
	VGA_COLOR_LIGHT_GREY        = 0x7,
	VGA_COLOR_DARK_GREY         = 0x8,
	VGA_COLOR_LIGHT_BLUE        = 0x9,
	VGA_COLOR_LIGHT_GREEN       = 0xA,
	VGA_COLOR_LIGHT_CYAN        = 0xB,
	VGA_COLOR_LIGHT_RED         = 0xC,
	VGA_COLOR_LIGHT_MAGENTA     = 0xD,
	VGA_COLOR_LIGHT_BROWN       = 0xE,
	VGA_COLOR_WHITE             = 0xF,
};

static inline uint8_t vga_entry_color(enum vga_color fg, enum vga_color bg) {
	return fg | bg << 4;
}

static inline uint16_t vga_entry(unsigned char c, uint8_t color) {
	return (uint16_t) c | (uint16_t) color << 8;
}
