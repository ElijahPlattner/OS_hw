# Makefile for ARM kernel project

all: kernel.elf

# Define commands and flags
CXX = aarch64-linux-gnu-g++
CC = aarch64-linux-gnu-gcc
LD = aarch64-linux-gnu-ld
CFLAGS = -g -pedantic -Wall -Wextra -fPIC -std=gnu2x
LDFLAGS = -g -N -Ttext=0x100000
ASMFLAGS = -g

# Source files
CSRC = kernel.c process.c queue.c
ASMSRC = boot.S box.S process_asm.S

# Object files
COBJ = $(patsubst %.c,%.o,$(CSRC)) 
ASMOBJ = $(patsubst %.S,%.o,$(ASMSRC))
ALLOBJ = $(COBJ) $(ASMOBJ)

# External libraries
OSLIB = libos.a

# Linking the kernel
kernel.elf: $(COBJ) $(ASMOBJ) $(OSLIB)
	$(LD) $(LDFLAGS) -o $@ $(COBJ) $(ASMOBJ) $(OSLIB)

# Rule to compile C files into object files
$(COBJ): %.o: %.c
	$(CC) $(CFLAGS) -MMD -c $< -o $@

# Rule to assemble assembly files into object files
$(ASMOBJ): %.o: %.S
	$(CC) $(ASMFLAGS) -MMD -c $< -o $@

.PHONY: clean run debug compress

# Running the kernel in QEMU
run:
	qemu-system-aarch64 -machine raspi3b -kernel kernel.elf

# Debugging the kernel with GDB and QEMU
debug:
	qemu-system-aarch64 -machine raspi3b -S -s -kernel kernel.elf &
	ddd --debugger 'gdb-multiarch -ex "target remote localhost:1234" -ex "break main" -ex "continue"' kernel.elf

# Cleaning object and output files
clean:
	rm -f *.o *.elf *.d

# Compress the project into a tar.gz archive
compress:
	bash -c 'dir=`pwd`; cd ..; tar -czf $$dir.tar.gz $$dir'
