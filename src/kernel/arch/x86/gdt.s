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

/*
 * Create the GDT
 */
gdt_start:
gdt_null:
.long 0x0
.long 0x0

gdt_kcode:
.word 0xFFFF             # limit
.word 0x0                # base
.byte 0x0                # base
.byte 0b10011010         # 1st flags | type flags
.byte 0b11001111         # 2nd flags | limit
.byte 0x0                # base

gdt_kdata:
.word 0xFFFF             # limit
.word 0x0                # base
.byte 0x0                # base
.byte 0b10010010         # 1st flags | type flags
.byte 0b11001111         # 2nd flags | limit
.byte 0x0                # base

gdt_ucode:
.word 0xFFFF             # limit
.word 0x0                # base
.byte 0x0                # base
.byte 0b11111010         # 1st flags | type flags
.byte 0b11001111         # 2nd flags | limit
.byte 0x0                # base

gdt_udata:
.word 0xFFFF             # limit
.word 0x0                # base
.byte 0x0                # base
.byte 0b11110010         # 1st flags | type flags
.byte 0b11001111         # 2nd flags | limit
.byte 0x0                # base

# TODO: setup the TSS
gdt_tss:
.word 0x0                # size of TSS (set later)
.word 0x0                # address of TSS (set later)
.byte 0x0                # address of TSS (set later)
.byte 0b10010001         # 1st flags | type flags
.byte 0b01000000         # 2nd flags | size of TSS (set later
.byte 0x0                # address of TSS (set later)

gdt_end:

gdtr:
.word (gdt_end - gdt_start - 1)
.long gdt_start
