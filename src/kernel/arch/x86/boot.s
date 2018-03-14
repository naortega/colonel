; Copyright (C) 2018  Ortega Froysa, Nicolás <nortega@themusicinnoise.net>
; Author: Ortega Froysa, Nicolás <nortega@themusicinnoise.net>
;
; This program is free software: you can redistribute it and/or modify
; it under the terms of the GNU General Public License as published by
; the Free Software Foundation, either version 3 of the License, or
; (at your option) any later version.
;
; This program is distributed in the hope that it will be useful,
; but WITHOUT ANY WARRANTY; without even the implied warranty of
; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
; GNU General Public License for more details.
;
; You should have received a copy of the GNU General Public License
; along with this program.  If not, see <http://www.gnu.org/licenses/>.

MBALIGN equ 1<<0               ; align loaded modules on page boundaries
MEMINFO equ 1<<1               ; provide memory map
FLAGS equ MBALIGN | MEMINFO    ; multiboot flag field
MAGIC equ 0x1BADB002           ; magic number to help bootloader find the header
CHECKSUM equ -(MAGIC + FLAGS)  ; checksum of the above data

section .multiboot
align 4
	dd MAGIC
	dd FLAGS
	dd CHECKSUM

section .bss
align 16
stack_bottom:
	resb 16384  ; 16KiB
stack_top:

section .data
%include "gdt.s"

section .text
global _start:function (_start.end - _start)
_start:
	; setup the stack
	mov esp, stack_top

	; TODO: setup GDT, IDT, paging, etc. here
	cli
	lgdt [gdtr]
	jmp 0x08:.reload_segs
.reload_segs:
	mov ax, 0x10
	mov ds, ax
	mov es, ax
	mov fs, ax
	mov gs, ax
	mov ss, ax

	; call the kernel
	extern kernel_main
	call kernel_main

	; hang
	cli
.hang:
	hlt
	jmp .hang
.end:
