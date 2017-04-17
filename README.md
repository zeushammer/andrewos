# andrewos
AndrewOS is built with 16Bit x86 assembly and runs an i386

## Building

These instructions are for Linux; I used the desktop version of Ubuntu 14.04

First, some dependencies:
`sudo apt-get install build-essential qemu nasm`

Now in a terminal:
`nasm -f bin -o andrewos.bin andrewos.asm`

This will assemble the code into a raw binary file. The -f bin flag says we want raw binary (not a Linux executable). The -o andrewos.bin part will generate a binary in a file called andrewos.bin.

Now we need a virtual floppy disk image to which we can write our bootloader-sized kernel. Copy andrewos.flp from the disk_images/ to your working directory then enter:

`dd status=noxfer conv=notrunc if=andrewos.bin of=andrewos.flp`

This uses the 'dd' utility to directly copy our kernel to the first sector of the floppy disk image. When it's done, we can boot our new OS using the QEMU PC emulator as follows:

qemu-system-i386 -fda andrew.flp

And there you are! If you want to use it on a real PC, you can write the floppy disk image to a real floppy and boot from it, or generate a CD-ROM ISO image. For the latter, make a new directory called cdiso and move the myfirst.flp file into it. Then, in your home directory, enter:

`mkisofs -o andrewos.iso -b andrewos.flp cdiso/`

This generates a CD-ROM ISO image called andrewos.iso with bootable floppy disk emulation, using the virtual floppy disk image from before. Now you can burn that ISO to a CD-R and boot your PC from it! (Note that you need to burn it as a direct ISO image and not just copy it onto a disc.)
