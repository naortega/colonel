# Copyright (C) 2018  Ortega Froysa, Nicolás <nortega@themusicinnoise.net>
# Author: Ortega Froysa, Nicolás <nortega@themusicinnoise.net>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# General options
TARGET=i686
ARCH=$(shell echo $(TARGET) | sed s/i.86/x86/)
# Assembly options
AS=i686-elf-as
AFLAGS=
# C options
CC=i686-elf-gcc
CFLAGS?=-O0 -g
CFLAGS:=$(CFLAGS) -std=gnu99 -ffreestanding -Wall -Wextra -Isrc/
# Linker options
LDFLAGS?=-O0
LDFLAGS:=$(LDFLAGS) -ffreestanding -nostdlib
LIBS=-lgcc

# Binary variables
OBJS=src/kernel/arch/$(ARCH)/boot.o src/kernel/kernel.o src/kernel/arch/$(ARCH)/tty.o

colonel.bin: $(OBJS)
	$(CC) -T src/kernel/arch/$(ARCH)/linker.ld -o $@ $(LDFLAGS) $^ $(LIBS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.s
	$(AS) $(AFLAGS) $< -o $@

.PHONY: all build-iso clean clean-all
all: colonel.bin

build-iso: colonel.iso

clean:
	rm -f $(OBJS)
	rm -rf isodir

clean-all: clean
	rm -f *.iso *.bin

colonel.iso: colonel.bin
	mkdir -p isodir/boot/grub/
	cp configs/grub.cfg isodir/boot/grub/
	cp $< isodir/boot/
	grub-mkrescue -o $@ isodir
