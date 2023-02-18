includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format db 4 dup("%08x "), 0Ah, 0

align 16
src1 dw 4 dup(1122h), 4 dup(3344h)
src2 dd 2 dup(11112222h), 2 dup(33334444h)
src3 dq 1111111122222222h, 3333333344444444h
src4 db 8 dup(0h), 8 dup(0FFh)

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    pxor xmm0, xmm0
    movdqa xmm1, xmmword ptr [src1]
    punpckhbw xmm0, xmm1
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
  
    pxor xmm0, xmm0
    movdqa xmm1, xmmword ptr [src2]
    punpckhwd xmm0, xmm1
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
  
    pxor xmm0, xmm0
    movdqa xmm1, xmmword ptr [src3]
    punpckhdq xmm0, xmm1
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
  
    pxor xmm0, xmm0
    movdqa xmm1, xmmword ptr [src4]
    punpckhqdq xmm0, xmm1
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

    pxor xmm0, xmm0
    movdqa xmm1, xmmword ptr [src1]
    punpcklbw xmm0, xmm1
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
  
    pxor xmm0, xmm0
    movdqa xmm1, xmmword ptr [src2]
    punpcklwd xmm0, xmm1
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
  
    pxor xmm0, xmm0
    movdqa xmm1, xmmword ptr [src3]
    punpckldq xmm0, xmm1
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
  
    pxor xmm0, xmm0
    movdqa xmm1, xmmword ptr [src4]
    punpcklqdq xmm0, xmm1
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

    movaps xmm0, xmmword ptr [src3]
    unpckhps xmm0, xmm0
    movups [rsp + 20], xmm0

    mov rcx, offset format
    mov edx, [rsp + 20]
    mov r8d, [rsp + 24]
    mov r9d, [rsp + 28]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movapd xmm0, xmmword ptr [src4]
    unpckhpd xmm0, xmm0
    movupd [rsp + 20], xmm0

    mov rcx, offset format
    mov edx, [rsp + 20]
    mov r8d, [rsp + 24]
    mov r9d, [rsp + 28]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movaps xmm0, xmmword ptr [src3]
    unpcklps xmm0, xmm0
    movups [rsp + 20], xmm0

    mov rcx, offset format
    mov edx, [rsp + 20]
    mov r8d, [rsp + 24]
    mov r9d, [rsp + 28]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movapd xmm0, xmmword ptr [src4]
    unpcklpd xmm0, xmm0
    movupd [rsp + 20], xmm0

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