includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format db 2 dup("%llu", 0Ah), 0

align 16
src dq 2 dup(1)

.code
main proc
    sub rsp, 40
  ; ------------------------------

    vmovaps xmm0, xmmword ptr [src]
    vmovups [rsp + 8], xmm0

    mov rcx, offset format
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movapd xmm0, [src]
    movupd [rsp + 8], xmm0

    mov rcx, offset format
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movdqa xmm0, xmmword ptr [src]
    movdqu [rsp + 8], xmm0

    mov rcx, offset format
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    call printf

  ; ------------------------------
    add rsp, 40
    xor eax, eax
    ret
main endp

end