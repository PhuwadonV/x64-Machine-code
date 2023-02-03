includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format db 4 dup("%f "), 0Ah, 0

align 16
src1 dd 0h, 0h, 3.0f, 4.0f
src2 dd 1.0f, 2.0f, 0h, 0h

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    vmovaps xmm0, [src1]
    vmovhlps xmm0, xmm0, xmm0
    vcvtps2pd ymm0, xmm0
    vmovupd [rsp + 8], ymm0

    mov rcx, offset format
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    mov r9, [rsp + 24]
    vzeroupper
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    vmovaps xmm0, [src2]
    vmovlhps xmm0, xmm0, xmm0
    vcvtps2pd ymm0, xmm0
    vmovupd [rsp + 8], ymm0

    mov rcx, offset format
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    mov r9, [rsp + 24]
    vzeroupper
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end