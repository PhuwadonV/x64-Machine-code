includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format1 db 4 dup("%f "), 0Ah, 0
format2 db "%f", 0Ah, 0

align 16
src1 dd 1.0f, 2.0f, 3.0f, 4.0f
src2 dq 1.0, 2.0

.code
main proc
    sub rsp, 40
  ; ------------------------------

    vmovaps xmm0, [src1]
    vinsertps xmm0, xmm0, xmm0, 80h
    vcvtps2pd ymm0, xmm0
    vmovups [rsp + 8], ymm0

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

    movaps xmm0, [src1]
    extractps edx, xmm0, 3h
    movd xmm0, edx
    cvtss2sd xmm0, xmm0

    mov rcx, offset format2
    movq rdx, xmm0
    call printf

  ; ------------------------------
    add rsp, 40
    xor eax, eax
    ret
main endp

end