#!/bin/bash
fileName=main
nasm -f elf64 -o $fileName.o $fileName.asm
if [[ $? -eq 0 ]]; then
    ld $fileName.o -o $fileName.bin
    rm $fileName.o
    exit 0
fi
exit 1