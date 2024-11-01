CC = gcc
CCFLAGS = -c -fno-stack-protector -fpic -fshort-wchar -mno-red-zone -Ignu-efi/inc -Ignu-efi/inc/x86_64 -DEFI_FUNCTION_WRAPPER

LD = ld
LDFLAGS = gnu-efi/x86_64/gnuefi/crt0-efi-x86_64.o -nostdlib -znocombreloc -Tgnu-efi/gnuefi/elf_x86_64_efi.lds -shared -Bsymbolic -Lgnu-efi/x86_64/lib -Lgnu-efi/x86_64/gnuefi -l:libgnuefi.a -l:libefi.a

OB = objcopy
OBFLAGS = -j .text -j .sdata -j .data -j .dynamic -j .dynsym -j .rel -j .rela -j .reloc --target=efi-app-x86_64

all: bootloader

bootloader: boot/main.o
	$(LD) $(LDFLAGS) -o tmp.so $<
	$(OB) $(OBFLAGS) tmp.so BOOTX64.EFI
	cp BOOTX64.EFI img

boot/%.o: boot/%.c
	$(CC) $(CCFLAGS) -o $@ $<

clean:
	rm -f boot/*.o *.EFI *.so
