includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
format db 4 dup("%d "), 0

align 16
src dd 1, 2, 3, 4
@mask dd 2 dup(80h, 0h)

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    lea rdi, [rsp + 20]
    movdqa xmm0, xmmword ptr [src]
    movdqa xmm1, xmmword ptr [@mask]

    maskmovdqu xmm0, xmm1

    mov rcx, offset format
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