all: kernel.elf
.global dispach
.extern enqueue
kernel.elf: kernel.o process.o queue.o boot.o box.o go.o process_asm.o libos.a
	aarch64-linux-gnu-ld -g -N -Ttext=0x100000 -o kernel.elf kernel.o boot.o box.o libos.a

kernel.o: kernel.c kernel.h# globals.h process.h
	aarch64-linux-gnu-gcc -g -pedantic -Wall -Wextra -fPIC -std=gnu2x -MMD -c kernel.c -o kernel.o

process.o: process.c proess.h globals.h pcb-alloc.h stack_alloc.h
	aarch64-linux-gnu-gcc -g -pedantic -Wall -Wextra -fPIC -std=gnu2x -MMD -c process.c -o process.o

queue.o: queue.c queue.h globals.h
	aarch64-linux-gnu-gcc -g -pedantic -Wall -Wextra -fPIC -std=gnu2x -MMD -c queue.c -o queue.o

boot.o: boot.S
	aarch64-linux-gnu-gcc -g -MMD -c boot.S -o boot.o

box.o: box.S
	aarch64-linux-gnu-gcc -g -MMD -c box.S -o box.o

go.o: go.S
	aarch64-linux-gnu-gcc -g -MMD -c go.S -o go.o

process_asm.o: process_asm.S
	aarch64-linux-gnu-gcc -g -MMD -c process_asm.S -o process_asm.o

run:
	qemu-system-aarch64 -machine raspi3b   -kernel kernel.elf

debug:
	qemu-system-aarch64 -machine raspi3b  -S -s -kernel kernel.elf &
	ddd --debugger 'gdb-multiarch -ex "target remote localhost:1234" -ex "break main" -ex "continue"' kernel.elf

clean:
	rm -f *.o *.d kernel.elf 

