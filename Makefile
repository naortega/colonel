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

untrue.bin: $(OBJS)
	$(CC) -T src/kernel/arch/$(ARCH)/linker.ld -o $@ $(LDFLAGS) $^ $(LIBS)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

%.o: %.s
	$(AS) $(AFLAGS) $< -o $@

.PHONY: all build-iso clean clean-all
all: untrue.bin

build-iso: untrue.iso

clean:
	rm -f $(OBJS)
	rm -rf isodir

clean-all: clean
	rm -f *.iso *.bin

untrue.iso: untrue.bin
	mkdir -p isodir/boot/grub/
	cp configs/grub.cfg isodir/boot/grub/
	cp $< isodir/boot/
	grub-mkrescue -o $@ isodir
