clean:
	rm main.bin
	rm main.o

build:
	nasm -f elf64 -o main.o main.asm
	ld main.o -o main.bin
	rm main.o

run: build
	./main.bin