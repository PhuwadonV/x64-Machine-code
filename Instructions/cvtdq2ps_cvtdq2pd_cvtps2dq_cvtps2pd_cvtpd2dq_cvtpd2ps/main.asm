includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format1 db 4 dup("%d "), 0Ah, 0
format2 db 2 dup("%d "), 0Ah, 0
format3 db 4 dup("%08x "), 0Ah, 0
format4 db 2 dup("%f "), 0Ah, 0
format5 db 4 dup("%f "), 0Ah, 0
format6 db 2 dup("%08x "), 0Ah, 0

align 16
src1 dd 1, 2, 3, 4
src2 dd 1, 2

align 16
src3 dd 1.0f, 2.0f, 3.0f, 4.0f
src4 dq 1.0, 2.0

.code
main proc
    sub rsp, 56
  ; ------------------------------

    movdqa xmm0, xmmword ptr [src1]
    cvtdq2ps xmm0, xmm0
    movups [rsp + 8], xmm0
    mov eax, [rsp + 20]
    mov [rsp + 32], eax

    mov rcx, offset format3
    mov edx, [rsp + 8]
    mov r8d, [rsp + 12]
    mov r9d, [rsp + 16]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movdqa xmm0, xmmword ptr [src2]
    cvtdq2pd xmm0, xmm0
    movupd [rsp + 8], xmm0

    mov rcx, offset format4
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movaps xmm0, xmmword ptr [src3]
    cvtps2dq xmm0, xmm0
    movups [rsp + 8], xmm0
    mov eax, [rsp + 20]
    mov [rsp + 32], eax

    mov rcx, offset format1
    mov edx, [rsp + 8]
    mov r8d, [rsp + 12]
    mov r9d, [rsp + 16]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    vmovaps xmm0, xmmword ptr [src3]
    vcvtps2pd ymm0, xmm0
    vmovupd [rsp + 8], ymm0

    mov rcx, offset format5
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    mov r9, [rsp + 24]
    vzeroupper
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movapd xmm0, xmmword ptr [src4]
    cvtpd2dq xmm0, xmm0
    movdqu [rsp + 8], xmm0

    mov rcx, offset format2
    mov edx, [rsp + 8]
    mov r8d, [rsp + 12]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movapd xmm0, xmmword ptr [src4]
    cvtpd2ps xmm0, xmm0
    movups [rsp + 8], xmm0

    mov rcx, offset format6
    mov edx, [rsp + 8]
    mov r8d, [rsp + 12]
    call printf

  ; ------------------------------
    add rsp, 56
    ret
main endp

end