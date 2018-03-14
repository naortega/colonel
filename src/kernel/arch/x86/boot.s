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

# declare constants for the multiboot header
.set ALIGN,      1 << 0            # align loaded modules on page boundaries
.set MEMINFO,    1 << 1            # provide memory map
.set FLAGS,      ALIGN | MEMINFO   # the multiboot `FLAG' field
.set MAGIC,      0x1BADB002        # 'magic number' letting the boot loader know we're here
.set CHECKSUM ,  -(MAGIC + FLAGS)  # checksum of the above to prove we're multiboot

/*
 * Declare the multiboot header marking this program as a kernel. The bootloader
 * will search for these values in the first 8 KiB of the kernel file aligned at
 * 32-bit boundaries (4 bytes). We put the signature in its own section to force
 * it within the first 8 KiB of the kernel file.
 */
.section .multiboot
.align 4
.long MAGIC
.long FLAGS
.long CHECKSUM

/*
 * Create a 16 byte aligned stack with 16 KiB of size. We create labels at the
 * bottom and top of the stack.
 */
.section .bss
.align 16
stack_bottom:
.skip 16384  # 16 KiB
stack_top:

/*
 * Create the GDT
 */
.section .data
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

/*
 * The linker script specifies the `_start' label as the entry point to the kernel
 * and the bootloader will jump to this position. That is, this is where the kernel
 * starts.
 */
.section .text
.global _start
.type _start, @function
_start:
	# set the position of `%esp' to the top of the stack
	mov $stack_top, %esp

	# GDT, paging, and other features
flush_gdt:
	cli
	lgdt (gdtr)
	movw $0x10, %ax
	movw %ax, %ds
	movw %ax, %es
	movw %ax, %fs
	movw %ax, %gs
	movw %ax, %ss
	ljmp $0x08, $flush_end
flush_end:

boot_kernel:
	# enter high-level kernel (C)
	call kernel_main

	# put computer into infinite loop
	cli                    # disable interrupts by clearing the interrupt flag in `eflags'
end_loop:
	hlt                    # wait for next interrupt
	jmp end_loop           # jump to the `hlt' instruction if it ever leaves it

.size _start, . - _start
