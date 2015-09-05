# faideos

## How to Build

*Note: These are my personal notes on how to compile/link the OS from source using the custom cross-compiler built on my machine.  It is not intended to work for other machines/users.  In the future this will probably be handled by a makefile.*

    # assemble the bootloader
    > i686-elf-as boot.s -o boot.o
    
    # compile the kernel
    > i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
    
    # link the kernel
    > i686-elf-gcc -T linker.ld -o faideos.bin -ffreestanding -O2 -nostdlib 
    >  boot.o kernel.o -lgcc
    
    # setup the iso structure
    > mkdir -p isodir
    > mkdir -p isodir/boot
    > mkdir -p isodir/grub
    > cp faideos.bin isodir/boot/faideos.bin
    > cp grub.cfg isodir/boot/grub/grub.cfg
     
    # bundle the iso with grub
    > grub2-mkrescue -o faideos.iso isodir

