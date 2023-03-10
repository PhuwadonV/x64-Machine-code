includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format1 db 2 dup("%f "), 0Ah, 0
format2 db "%f", 0Ah, 0

align 16
src1 dd 1.0f, 2.0f, 3.0f, 4.0f
src2 dq 1.0, 2.0
src3 dd 2.0f, 1.0f, 4.0f, 2.0f
src4 dq 6.0, 3.0

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    movaps xmm0, [src1]
    haddps xmm0, xmm0
    cvtps2pd xmm0, xmm0
    movupd [rsp + 8], xmm0

    mov rcx, offset format1
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movapd xmm0, [src2]
    haddpd xmm0, xmm0
    movupd [rsp + 8], xmm0

    mov rcx, offset format2
    mov rdx, [rsp + 8]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movaps xmm0, [src3]
    hsubps xmm0, xmm0
    cvtps2pd xmm0, xmm0
    movupd [rsp + 8], xmm0

    mov rcx, offset format1
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movapd xmm0, [src4]
    hsubpd xmm0, xmm0
    movupd [rsp + 8], xmm0

    mov rcx, offset format2
    mov rdx, [rsp + 8]
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end