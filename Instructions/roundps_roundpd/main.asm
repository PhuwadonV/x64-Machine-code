includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format1 db 4 dup("%f "), 0Ah, 0
format2 db 2 dup("%f "), 0Ah, 0

align 16
src1 dd 1.5f, 2.5f, 3.5f, 4.5f
src2 dq 1.5, 2.5

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    vmovaps xmm0, [src1]
    vroundps xmm0, xmm0, 2h
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

    movapd xmm0, [src2]
    roundpd xmm0, xmm0, 2h
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