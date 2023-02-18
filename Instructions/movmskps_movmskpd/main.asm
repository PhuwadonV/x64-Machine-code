includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format1 db 4 dup("%d "), 0Ah, 0
format2 db "%08x", 0Ah, 0

align 16
src dd 1, 2, 3, 4
@mask1 dd 2 dup(80000000h, 0h)
@mask2 dq 8000000000000000h, 0h

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    movaps xmm0, [@mask1]
    movmskps edx, xmm0

    mov rcx, offset format2
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movapd xmm0, [@mask2]
    movmskpd edx, xmm0

    mov rcx, offset format2
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end