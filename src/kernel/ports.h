/*
 * Copyright (C) 2018  Ortega Froysa, Nicolás <nortega@themusicinnoise.net>
 * Author: Ortega Froysa, Nicolás <nortega@themusicinnoise.net>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

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
