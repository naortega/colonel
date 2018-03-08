UntrueOS
========
This is a small OS project I'm working on. It's slow progress and probably shouldn't be run anywhere except in an emulator. It currently supports the following architectures:
 - x86

Compiling
---------
You'll want to setup a cross-compilation toolchain with [GCC](https://gcc.gnu.org/) for your target architecture, along with [GNU Make](https://www.gnu.org/software/make/) (I'll switch to the GNU autotools as soon as I can get them to work properly).

To compile a full image you can run `make build-iso`, which will use [GNU GRUB](https://www.gnu.org/software/grub/) as the bootloader. Else, just run `make` and it will build the kernel into a file called `untrue.bin`. You can run the latter with [QEMU](https://www.qemu.org/) by using the `-kernel` option.

License
-------
This project is licensed under the terms and conditions of the [GNU General Public License version 3 or greater](/LICENSE).
