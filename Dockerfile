FROM ubuntu:20.04

# Install packages
RUN apt update -y
RUN apt install -y nasm=2.14.02-1 cmake=3.16.3-1ubuntu1

# Copy files
COPY main.asm .
COPY Makefile .

# Compile assembly
RUN make build

ENTRYPOINT [ "./main.bin" ]
