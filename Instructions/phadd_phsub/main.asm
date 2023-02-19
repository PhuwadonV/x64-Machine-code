includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format1 db 4 dup("%08x "), 0Ah, 0

align 16
src1 dw 8, 7, 6, 5, 4, 3, 2, 1
src2 dd 4, 3, 2, 1

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    movdqa xmm0, xmmword ptr [src1]
    phaddw xmm0, xmm0 
    movupd [rsp + 20], xmm0

    mov rcx, offset format1
    mov edx, [rsp + 20]
    mov r8d, [rsp + 24]
    mov r9d, [rsp + 28]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movdqa xmm0, xmmword ptr [src2]
    phaddd xmm0, xmm0 
    movupd [rsp + 20], xmm0

    mov rcx, offset format1
    mov edx, [rsp + 20]
    mov r8d, [rsp + 24]
    mov r9d, [rsp + 28]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movdqa xmm0, xmmword ptr [src1]
    phsubw xmm0, xmm0 
    movupd [rsp + 20], xmm0

    mov rcx, offset format1
    mov edx, [rsp + 20]
    mov r8d, [rsp + 24]
    mov r9d, [rsp + 28]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movdqa xmm0, xmmword ptr [src2]
    phsubd xmm0, xmm0 
    movupd [rsp + 20], xmm0

    mov rcx, offset format1
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