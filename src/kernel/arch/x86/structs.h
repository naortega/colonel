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

#include <stdint.h>

struct segdesc {
	uint16_t limit_low;
	uint16_t base_low;
	uint8_t base_mid;
	uint8_t access;
	uint8_t gran;
	uint8_t base_high;
} __attribute__((packed));

struct tss {
	uint16_t link;
	uint16_t link_r;    // reserved

	uint32_t esp0;
	uint16_t ss0;
	uint16_t ss0_r;     // reserved

	uint32_t esp1;
	uint16_t ss1;
	uint16_t ss1_r;     // reserved

	uint32_t esp2;
	uint16_t ss2;
	uint16_t ss2_r;     // reserved

	uint32_t cr3;
	uint32_t eip;
	uint32_t eflags;
	uint32_t eax;
	uint32_t ecx;
	uint32_t edx;
	uint32_t ebx;
	uint32_t esp;
	uint32_t ebp;
	uint32_t esi;
	uint32_t edi;

	uint16_t es;
	uint16_t es_r;     // reserved
	uint16_t cs;
	uint16_t cs_r;     // reserved
	uint16_t ss;
	uint16_t ss_r;     // reserved
	uint16_t ds;
	uint16_t ds_r;     // reserved
	uint16_t fs;
	uint16_t fs_r;     // reserved
	uint16_t gs;
	uint16_t gs_r;     // reserved
	uint16_t ldtr;
	uint16_t ldtr_r;   // reserved
	uint16_t iopb_r;   // reserved
	uint16_t iopb;
} __attribute__((packed));

struct segreg {
	uint16_t limit;
	uint32_t base;
} __attribute__((packed));
