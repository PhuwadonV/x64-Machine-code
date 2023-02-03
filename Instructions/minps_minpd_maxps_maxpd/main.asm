includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format1 db 4 dup("%f "), 0Ah, 0
format2 db 2 dup("%f "), 0Ah, 0

align 16
src1 dd 1.0f, 2.0f, 3.0f, 4.0f
src2 dd 4.0f, 3.0f, 2.0f, 1.0f
src3 dq 1.0, 2.0
src4 dq 2.0, 1.0

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    vmovaps xmm0, [src1]
    vmovaps xmm1, [src2]
    vminps xmm0, xmm0, xmm1
    vcvtps2pd ymm0, xmm0
    vmovupd [rsp + 8], ymm0

    mov rcx, offset format1
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    mov r9, [rsp + 24]
    vzeroupper
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movapd xmm0, [src3]
    movapd xmm1, [src4]
    minpd xmm0, xmm1
    movupd [rsp + 8], xmm0

    mov rcx, offset format2
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    vmovaps xmm0, [src1]
    vmovaps xmm1, [src2]
    vmaxps xmm0, xmm0, xmm1
    vcvtps2pd ymm0, xmm0
    vmovupd [rsp + 8], ymm0

    mov rcx, offset format1
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    mov r9, [rsp + 24]
    vzeroupper
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movapd xmm0, [src3]
    movapd xmm1, [src4]
    maxpd xmm0, xmm1
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