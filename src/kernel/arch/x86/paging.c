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

#include <stdint.h>
#include <stddef.h>

uint32_t page_dir[1024] __attribute__((aligned(4096)));
uint32_t page_table[1024] __attribute__((aligned(4096)));

uint32_t *setup_paging() {
	/*
	 * set all pages to:
	 *  - supervisor: only kernel-mode can access
	 *  - write enabled: can be read and written
	 *  - not present: the page table is not present
	 */
	for(size_t i = 0; i < 1024; ++i)
		page_dir[i] = 0x00000002;

	/*
	 * fill the 1024 entries of the table with the flags
	 * supervisor, write enabled, and PRESENT.
	 */
	for(size_t i = 0; i < 1024; ++i)
		page_table[i] = (i * 0x1000) | 3;

	// put page table in first directory and enable the present
	// flag
	page_dir[0] = ((uint32_t) page_table) | 3;

	return page_dir;
}
