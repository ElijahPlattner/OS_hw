# Compiler and flags
CC = aarch64-linux-gnu-gcc
LD = aarch64-linux-gnu-ld
CFLAGS = -g -pedantic -Wall -Wextra -fPIC -std=gnu2x
ASFLAGS = -g
LD_FLAGS = -g -N -Ttext=0x100000

# Source files
C_SOURCES = kernel.c process.c queue.c
ASM_SOURCES = boot.S box.S process_asm.S
OBJECTS = $(C_SOURCES:.c=.o) $(ASM_SOURCES:.S=.o)
LIBS = libos.a

# Output file
OUTPUT = kernel.elf

# Default target
all: $(OUTPUT)

# Linking
$(OUTPUT): $(OBJECTS) $(LIBS)
	$(LD) $(LD_FLAGS) -o $@ $(OBJECTS) $(LIBS)

# Compiling C source files
%.o: %.c
	$(CC) $(CFLAGS) -MMD -c $< -o $@

# Compiling Assembly source files
%.o: %.S
	$(CC) $(ASFLAGS) -MMD -c $< -o $@

# Running the kernel
run:
	qemu-system-aarch64 -machine raspi3b -kernel $(OUTPUT)

# Debugging the kernel
debug:
	qemu-system-aarch64 -machine raspi3b -S -s -kernel $(OUTPUT) &
	ddd --debugger 'gdb-multiarch -ex "target remote localhost:1234" -ex "break main" -ex "continue"' $(OUTPUT)

# Cleaning up
clean:
	rm -f *.o *.d $(OUTPUT)

# Include dependency files
-include $(OBJECTS:.o=.d)
