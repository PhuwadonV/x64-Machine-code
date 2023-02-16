includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format1 db 4 dup("%08x "), 0Ah, 0
format2 db 2 dup("%016llx "), 0Ah, 0

align 16
src1 dq 1122334455667788h, 99AABBCCDDEEFFh
src2 db 16 dup(0h)
src3 db 4 dup(11h), 4 dup(22h), 4 dup(33h), 4 dup(44h)
src4 db 4 dup(55h), 4 dup(66h), 4 dup(77h), 4 dup(88h)
src5 db 8 dup(11h), 8 dup(22h)
src6 db 8 dup(33h), 8 dup(44h)

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    movdqa xmm0, xmmword ptr [src1]
    movdqa xmm1, xmmword ptr [src2]
    pshufb xmm0, xmm1
    movdqu [rsp + 20], xmm0

    mov rcx, offset format1
    mov edx, [rsp + 20]
    mov r8d, [rsp + 24]
    mov r9d, [rsp + 28]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movdqa xmm0, xmmword ptr [src3]
    pshufhw xmm0, xmm0, 0
    movdqu [rsp + 20], xmm0

    mov rcx, offset format1
    mov edx, [rsp + 20]
    mov r8d, [rsp + 24]
    mov r9d, [rsp + 28]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movdqa xmm0, xmmword ptr [src3]
    pshuflw xmm0, xmm0, 0
    movdqu [rsp + 20], xmm0

    mov rcx, offset format1
    mov edx, [rsp + 20]
    mov r8d, [rsp + 24]
    mov r9d, [rsp + 28]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movdqa xmm0, xmmword ptr [src3]
    pshufd xmm0, xmm0, 0E4h
    movdqu [rsp + 20], xmm0

    mov rcx, offset format1
    mov edx, [rsp + 20]
    mov r8d, [rsp + 24]
    mov r9d, [rsp + 28]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movaps xmm0, xmmword ptr [src3]
    movaps xmm1, xmmword ptr [src4]
    shufps xmm0, xmm1, 0
    movups [rsp + 20], xmm0

    mov rcx, offset format1
    mov edx, [rsp + 20]
    mov r8d, [rsp + 24]
    mov r9d, [rsp + 28]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movapd xmm0, xmmword ptr [src5]
    movapd xmm1, xmmword ptr [src6]
    shufpd xmm0, xmm1, 0
    movupd [rsp + 8], xmm0

    mov rcx, offset format2
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end