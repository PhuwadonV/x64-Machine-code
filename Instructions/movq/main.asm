includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
format db 4 dup("%08x "), 0Ah, 0

align 16
src db 16 dup(0FFh)

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    mov eax, 0FFFFFFFFh
    movdqa xmm1, xmmword ptr [src]
    movq xmm0, xmm1
    movdqu [rsp + 20], xmm0

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