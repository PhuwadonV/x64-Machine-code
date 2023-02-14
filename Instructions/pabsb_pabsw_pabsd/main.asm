includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format db 2 dup("%016llx "), 0Ah, 0

align 16
src1 db 16 dup(-1)
src2 dw 8 dup(-1)
src3 dd 4 dup(-1)
src4 dq 2 dup(-1)

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    movdqa xmm0, xmmword ptr [src1]
    pabsb xmm0, xmm0
    movdqu [rsp + 8], xmm0

    mov rcx, offset format
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movdqa xmm0, xmmword ptr [src2]
    pabsw xmm0, xmm0
    movdqu [rsp + 8], xmm0

    mov rcx, offset format
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movdqa xmm0, xmmword ptr [src3]
    pabsd xmm0, xmm0
    movdqu [rsp + 8], xmm0

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