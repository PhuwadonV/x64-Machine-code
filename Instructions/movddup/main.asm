includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
format db 2 dup("%f "), 0Ah, 0

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    mov rax, 3FF0000000000000h ; 1.0
    movq xmm0, rax
    movddup xmm0, xmm0
    movupd [rsp + 8], xmm0

    mov rcx, offset format
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end