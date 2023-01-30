includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format db 4 dup("%08x "), 0Ah, 0

align 16
src1 db 16 dup(011h)
src2 db 16 dup(022h)
value1 db 8 dup(80h, 0h)
value2 dd 2 dup(0h, 80000000h)
value3 dq 0h, 8000000000000000h

.code
main proc
    sub rsp, 40
  ; ------------------------------

    movdqa xmm0, xmmword ptr [value1]
    movdqa xmm1, xmmword ptr [src1]
    movdqa xmm2, xmmword ptr [src2]
    pblendvb xmm1, xmm2, xmm0
    movdqu [rsp + 8], xmm1
    mov eax, [rsp + 20]

    mov rcx, offset format
    mov edx, [rsp + 8]
    mov r8d, [rsp + 12]
    mov r9d, [rsp + 16]
    mov [rsp + 32], eax
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movdqa xmm0, xmmword ptr [src1]
    movdqa xmm1, xmmword ptr [src2]
    pblendw xmm0, xmm1, 055h
    movdqu [rsp + 8], xmm0
    mov eax, [rsp + 20]

    mov rcx, offset format
    mov edx, [rsp + 8]
    mov r8d, [rsp + 12]
    mov r9d, [rsp + 16]
    mov [rsp + 32], eax
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movdqa xmm0, xmmword ptr [src1]
    movdqa xmm1, xmmword ptr [src2]
    vpblendd xmm0, xmm0, xmm1, 0Ah
    movdqu [rsp + 8], xmm0
    mov eax, [rsp + 20]

    mov rcx, offset format
    mov edx, [rsp + 8]
    mov r8d, [rsp + 12]
    mov r9d, [rsp + 16]
    mov [rsp + 32], eax
    vzeroupper
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movaps xmm0, xmmword ptr [src1]
    movaps xmm1, xmmword ptr [src2]
    blendps xmm0, xmm1, 0Ah
    movups [rsp + 8], xmm0
    mov eax, [rsp + 20]

    mov rcx, offset format
    mov edx, [rsp + 8]
    mov r8d, [rsp + 12]
    mov r9d, [rsp + 16]
    mov [rsp + 32], eax
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movdqa xmm0, xmmword ptr [value2]
    movaps xmm1, xmmword ptr [src1]
    movaps xmm2, xmmword ptr [src2]
    blendvps xmm1, xmm2, xmm0
    movups [rsp + 8], xmm1
    mov eax, [rsp + 20]

    mov rcx, offset format
    mov edx, [rsp + 8]
    mov r8d, [rsp + 12]
    mov r9d, [rsp + 16]
    mov [rsp + 32], eax
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movapd xmm0, xmmword ptr [src1]
    movapd xmm1, xmmword ptr [src2]
    blendpd xmm0, xmm1, 2h
    movupd [rsp + 8], xmm0
    mov eax, [rsp + 20]

    mov rcx, offset format
    mov edx, [rsp + 8]
    mov r8d, [rsp + 12]
    mov r9d, [rsp + 16]
    mov [rsp + 32], eax
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movdqa xmm0, xmmword ptr [value3]
    movapd xmm1, xmmword ptr [src1]
    movapd xmm2, xmmword ptr [src2]
    blendvpd xmm1, xmm2, xmm0
    movupd [rsp + 8], xmm1
    mov eax, [rsp + 20]

    mov rcx, offset format
    mov edx, [rsp + 8]
    mov r8d, [rsp + 12]
    mov r9d, [rsp + 16]
    mov [rsp + 32], eax
    call printf

  ; ------------------------------
    add rsp, 40
    xor eax, eax
    ret
main endp

end