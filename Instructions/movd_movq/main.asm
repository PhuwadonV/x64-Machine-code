includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format db 4 dup("%08x "), 0Ah, 0

align 16
src db 16 dup(0FFh)

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    mov eax, 0FFFFFFFFh
    movdqa xmm0, xmmword ptr [src]
    movd xmm0, eax
    movdqu [rsp + 8], xmm0
    mov eax, [rsp + 20]
    mov [rsp + 32], eax

    mov rcx, offset format
    mov edx, [rsp + 8]
    mov r8d, [rsp + 12]
    mov r9d, [rsp + 16]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov rax, 0FFFFFFFFFFFFFFFFh
    movdqa xmm0, xmmword ptr [src]
    movq xmm0, rax
    movdqu [rsp + 8], xmm0
    mov eax, [rsp + 20]
    mov [rsp + 32], eax

    mov rcx, offset format
    mov edx, [rsp + 8]
    mov r8d, [rsp + 12]
    mov r9d, [rsp + 16]
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end