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

gdt_start:

gdt_null:
	dd 0x0
	dd 0x0

gdt_kcode:
	dw 0xFFFF     ; limit (bits 0-15)
	dw 0x0        ; base (bits 0-15)

	db 0x0        ; base (bits 16-23)
	db 10011010b  ; 1st flags | type flags
	db 11001111b  ; 2nd flags | limit (bits 16-19)
	db 0x0        ; base (bits 24-31)

gdt_kdata:
	dw 0xFFFF
	dw 0x0

	db 0x0
	db 10010010b
	db 11001111b
	db 0x0

gdt_ucode:
	dw 0xFFFF
	dw 0x0

	db 0x0
	db 11111010b
	db 11001111b
	db 0x0

gdt_udata:
	dw 0xFFFF
	dw 0x0

	db 0x0
	db 11110010b
	db 11001111b
	db 0x0

; TODO: fill this in later
gdt_tss:
	dd 0x0
	dd 0x0

gdt_end:

gdtr:
	dw gdt_end  - gdt_start - 1
	dd gdt_start
