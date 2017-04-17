BITS 16

start:
mov ax, 07C0h		; Set up 4K stack space after this bootloader
add ax, 288		; (4096 + 512) / 16 bytes per paragraph
mov ss, ax
mov sp, 4096

mov ax, 07C0h		; Set data segment to where we're loaded
mov ds, ax      ; Finish settings up memory segments


mov si, text_string	; Copy the loc of the txt string into the SI register
call print_string	; Call our string-printing routine

jmp $			; Jump here - infinite loop!


text_string db 'This is my cool new AndrewOS!', 0


print_string:			; Routine: output string in SI to screen
mov ah, 0Eh		; 0Eh in the AH register means "print the char in AL"
              ; Where ah is AX high and AL is AX low

.repeat:
lodsb			; load the next byte from SI (increment SI each time)
cmp al, 0   ; compare if AX low is 0
je .done		; If char is zero, end of string
int 10h			; Otherwise, print it
jmp .repeat

.done:
ret

                      ; For a PC to recongize a valid floppy boot sector, it has to be
                      ; exactly 512 bytes in size and end with the number AAh and 55j
times 510-($-$$) db 0	; Pad remainder of boot sector with 0s
dw 0xAA55		          ; The standard PC boot signature
