; https://filippo.io/linux-syscall-table/

section .data
    question db "Enter string: "
    question_length equ $-question

    by dq 0x1

section .bss
    userInputBuffer resb 16 ; reserve 16 bytes  

section .text
    global _start

_start:
    call _askUserForString
    
    mov rax, userInputBuffer ; Address of first character in string
    mov rbx, 16 ; Length of string
    call _encryptString

    call _printMessage
    call _return

_encryptString:
    mov rdx, 0 ; i = 0

    _encryptionLoop: ; If the next character is 0x0A (Enter), there is no more data
    mov r9, [rax+rdx]
    cmp r9, 0x0A
    je _exit

    ; Encrypt 1 character
    mov rcx, [rax+rdx]
    add rcx, [by]
    mov [rax+rdx], rcx

    ; i++; i != length
    inc rdx
    cmp rdx, rbx
    jnz _encryptionLoop

    _exit:
    ret

_askUserForString:
    mov rax, question
    mov rbx, question_length
    call _printMessage
    
    call _getInput
    ret
_getInput:
    mov rax, 0    ; sys_read
    mov rdi, 0    ; stdin (1 = stdout, 2 = stderr)
    mov rsi, userInputBuffer ; Save to userInputBuffer
    mov rdx, 16   ; How many bytes to save
    syscall
    ret
_printMessage:
    mov rsi, rax ; string to print
    mov rdx, rbx ; length of string

    mov rax, 1 ; sys_write
    mov rdi, 1 ; stdout (0 = stdin, 2 = stderr)
    syscall
    ret
_return:
    mov rax, 60 ; sys_exit
    mov rdi, 0  ; exit code
    syscall


; Decompiled Ghidra result of _encryptString

; void _encryptString(void)
; {
;   long string;
;   long i;
;   long string_length;
  
;   i = 0;
;   do {
;     if (*(long *)(string + i) == L'\n') {
;       return;
;     }
;     *(long *)(string + i) = *(long *)(string + i) + _incrementBy;
;     i = i + 1;
;   } while (i != string_length);
;   return;
; }

; Cleaned result:
; void _encryptString(void)
; {
;     for (long i = 0; i != string_length; i++) {
;         if (string[i] == '\n') {
;             return;
;         }

;         string[i] += _incrementBy;
;     }
; }