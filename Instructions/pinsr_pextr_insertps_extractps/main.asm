includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format1 db 4 dup("%08x "), 0Ah, 0
format2 db "%016llx", 0Ah, 0
format3 db 4 dup("%f "), 0Ah, 0
format4 db "%f", 0Ah, 0

align 16
src1 db 16 dup(11h)
src2 dq 1122334455667788h, 99AABBCCDDEEFFh
src3 dd 1.0f, 2.0f, 3.0f, 4.0f
src4 dq 1.0, 2.0

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    movdqa xmm0, xmmword ptr [src1]
    mov eax, 99h
    pinsrb xmm0, eax, 0
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

    movdqa xmm0, xmmword ptr [src1]
    mov eax, 9999h
    pinsrw xmm0, eax, 0
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

    movdqa xmm0, xmmword ptr [src1]
    mov eax, 99999999h
    pinsrd xmm0, eax, 0
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

    movdqa xmm0, xmmword ptr [src1]
    mov rax, 9999999999999999h
    pinsrq xmm0, rax, 0
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

    movdqa xmm0, xmmword ptr [src2]
    pextrb edx, xmm0, 0

    mov rcx, offset format2
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movdqa xmm0, xmmword ptr [src2]
    pextrw edx, xmm0, 0

    mov rcx, offset format2
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movdqa xmm0, xmmword ptr [src2]
    pextrd edx, xmm0, 0

    mov rcx, offset format2
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movdqa xmm0, xmmword ptr [src2]
    pextrq rdx, xmm0, 0

    mov rcx, offset format2
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    vmovaps xmm0, xmmword ptr [src3]
    vinsertps xmm0, xmm0, xmm0, 80h
    vcvtps2pd ymm0, xmm0
    vmovupd [rsp + 8], ymm0

    mov rcx, offset format3
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    mov r9, [rsp + 24]
    vzeroupper
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movaps xmm0, xmmword ptr [src4]
    extractps edx, xmm0, 3h
    movd xmm0, edx
    cvtss2sd xmm0, xmm0

    mov rcx, offset format4
    movq rdx, xmm0
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end