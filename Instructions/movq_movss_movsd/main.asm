includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format db 4 dup("%08x "), 0Ah, 0

align 16
src1 db 16 dup(011h)
src2 db 16 dup(022h)

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    mov eax, 0FFFFFFFFh
    movdqa xmm0, xmmword ptr [src1]
    movdqa xmm1, xmmword ptr [src2]
    movq xmm0, xmm1
    movdqu [rsp + 20], xmm0

    mov rcx, offset format
    mov edx, [rsp + 20]
    mov r8d, [rsp + 24]
    mov r9d, [rsp + 28]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov eax, 0FFFFFFFFh
    movdqa xmm0, xmmword ptr [src1]
    movdqa xmm1, xmmword ptr [src2]
    movss xmm0, xmm1
    movdqu [rsp + 20], xmm0

    mov rcx, offset format
    mov edx, [rsp + 20]
    mov r8d, [rsp + 24]
    mov r9d, [rsp + 28]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov eax, 0FFFFFFFFh
    movdqa xmm0, xmmword ptr [src1]
    movdqa xmm1, xmmword ptr [src2]
    movsd xmm0, xmm1
    movdqu [rsp + 20], xmm0

    mov rcx, offset format
    mov edx, [rsp + 20]
    mov r8d, [rsp + 24]
    mov r9d, [rsp + 28]
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end