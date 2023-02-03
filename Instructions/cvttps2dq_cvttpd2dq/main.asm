includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format1 db 4 dup("%d "), 0Ah, 0
format2 db 2 dup("%d "), 0Ah, 0

align 16
src1 dd 1.9f, 2.9f, 3.9f, 4.9f
src2 dq 1.9, 2.9

.code
main proc
    sub rsp, 32 + 16 + 8
  ; ------------------------------

    movaps xmm0, xmmword ptr [src1]
    cvttps2dq xmm0, xmm0
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

    movapd xmm0, xmmword ptr [src2]
    cvttpd2dq xmm0, xmm0
    movdqu [rsp + 8], xmm0

    mov rcx, offset format2
    mov edx, [rsp + 8]
    mov r8d, [rsp + 12]
    call printf

  ; ------------------------------
    add rsp, 32 + 16 + 8
    xor eax, eax
    ret
main endp

end