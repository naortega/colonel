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

#include "gdt.h"

/*
 * ENTRIES:
 * 0    - NULL entry
 * 1/2  - kernel entries
 * 3/4  - user entries
 * 5    - TSS entry
 */
#define GDT_SIZE 3

struct segdesc gdt[GDT_SIZE];
struct segreg gdtr;

void gdt_entry_set(struct segdesc *entry, uint32_t base,
		uint32_t limit, uint8_t access, uint8_t gran) {
	// base
	entry->base_low = base & 0xFFFF;
	entry->base_mid = (base >> 16) & 0xFF;
	entry->base_high = (base >> 24) & 0xFF;

	// limit
	entry->limit_low = limit & 0xFFFF;
	entry->gran = (limit >> 16) & 0x0F;

	// access and granularity flags
	entry->gran |= gran & 0xF0;
	entry->access = access;
}

void gdt_install() {
	gdtr.base = (uint32_t)gdt;
	gdtr.limit = sizeof(gdt)-1;

	gdt_entry_set(&gdt[0], 0, 0, 0, 0);
	gdt_entry_set(&gdt[1], 0, 0xFFFFFFFF, 0x9A, 0xCF);
	gdt_entry_set(&gdt[2], 0, 0xFFFFFFFF, 0x92, 0xCF);

	gdt_flush(&gdtr);
}
