#pragma once

static inline void outb(uint16_t port, uint8_t data) {
	__asm__("outb %%al, %%dx" : : "a" (data), "d" (port));
}

static inline void outw(uint16_t port, uint16_t data) {
	__asm__("outw %%ax, %%dx" : : "a" (data), "d" (port));
}

static inline uint8_t inb(uint16_t port) {
	uint8_t res;
	__asm__("inb %%dx, %%al" : "=a" (res) : "d" (port));
	return res;
}

static inline uint16_t inw(uint16_t port) {
	uint16_t res;
	__asm__("inw %%dx, %%ax" : "=a" (res) : "d" (port));
	return res;
}
