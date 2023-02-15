includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format1 db 2 dup("%f "), 0Ah, 0
format2 db 4 dup("%08x "), 0Ah, 0

align 16
src dd 2 dup(99h, 1.0f)

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    mov rax, 3FF0000000000000h ; 1.0
    movq xmm0, rax
    movddup xmm0, xmm0
    movupd [rsp + 8], xmm0

    mov rcx, offset format1
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movaps xmm0, [src]
    movshdup xmm0, xmm0
    movups [rsp + 20], xmm0

    mov rcx, offset format2
    mov edx, [rsp + 20]
    mov r8d, [rsp + 24]
    mov r9d, [rsp + 28]
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end