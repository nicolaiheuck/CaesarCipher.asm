# Caesar cipher in assembly
Because why not!

## Try it out locally
This requires you to install the packages: **nasm** and **cmake**
```bash
sudo apt install -y nasm cmake
git clone https://github.com/nicolaiheuck/Own.CaesarCipher.asm.git
cd Own.CaesarCipher.asm
make run
```

## Or in docker
This way you don't have to install any dependencies (except docker)
```bash
git clone https://github.com/nicolaiheuck/Own.CaesarCipher.asm.git
docker build Own.CaesarCipher.asm -t caesar-cipher
docker run --rm -it caesar-cipher # The container will delete it-self when you exit
```

# What is Caesar cipher?
[Wiki](https://en.wikipedia.org/wiki/Caesar_cipher)
