all: kernel.elf

kernel.elf: kernel.o boot.o box.o libos.a
	aarch64-linux-gnu-ld -g -N -Ttext=0x100000 -o kernel.elf kernel.o boot.o box.o libos.a

kernel.o: kernel.c
	aarch64-linux-gnu-gcc -g -pedantic -Wall -Wextra -fPIC -std=gnu2x -MMD -c kernel.c -o kernel.o

boot.o: boot.S
	aarch64-linux-gnu-gcc -g -MMD -c boot.S -o boot.o

box.o: box.S
	aarch64-linux-gnu-gcc -g -MMD -c box.S -o box.o

clean:
	rm -f *.o *.d kernel.elf 