includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format1 db 4 dup("%d "), 0Ah, 0
format2 db "%08x", 0Ah, 0

align 16
src dd 1, 2, 3, 4
@mask1 dd 2 dup(80h, 0h)
@mask2 dd 2 dup(80000000h, 0h)
@mask3 dq 8000000000000000h, 0h

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    lea rdi, [rsp + 20]
    movdqa xmm0, xmmword ptr [src]
    movdqa xmm1, xmmword ptr [@mask1]

    maskmovdqu xmm0, xmm1

    mov rcx, offset format1
    mov edx, [rsp + 20]
    mov r8d, [rsp + 24]
    mov r9d, [rsp + 28]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movaps xmm0, [@mask2]
    movmskps edx, xmm0

    mov rcx, offset format2
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movapd xmm0, [@mask3]
    movmskpd edx, xmm0

    mov rcx, offset format2
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end