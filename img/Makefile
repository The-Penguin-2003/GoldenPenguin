CC = gcc -D _POSIX_C_SOURCE=200809L
CCFLAGS = -std=c17 -Wall -Wextra -Wpedantic -O2

VM = qemu-system-x86_64
VMFLAGS = -M q35 -display sdl -m 1G -smp 8 -serial stdio -bios ../ovmf/bios64.bin -drive if=pflash,format=raw,unit=0,file=../ovmf/OVMF_CODE-pure-efi.fd,readonly=on -drive if=pflash,format=raw,unit=1,file=../ovmf/OVMF_VARS-pure-efi.fd -net none -drive format=raw,file=GoldenPenguin.hdd

all: write_gpt run vm

write_gpt: write_gpt.c
	$(CC) $(CCFLAGS) -o $@ $<

run:
	./write_gpt

vm:
	$(VM) $(VMFLAGS)

clean:
	rm -f write_gpt *.hdd *.INF *.EFI
