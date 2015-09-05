all: asm kernel ld iso

asm: boot.s
	i686-elf-as boot.s -o boot.o

kernel: kernel.c
	i686-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra

ld: boot.o kernel.o linker.ld 
	i686-elf-gcc -T linker.ld -o faideos.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc

iso: faideos.bin grub.cfg
	mkdir -p isobuild
	mkdir -p isobuild/boot
	mkdir -p isobuild/boot/grub
	cp faideos.bin isobuild/boot/faideos.bin
	cp grub.cfg isobuild/boot/grub/grub.cfg
	grub2-mkrescue -o faideos.iso isobuild

clean:
	rm -rf *.o *.iso *.bin isobuild 2>/dev/null || true
