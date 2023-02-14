includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format db 4 dup("%08x "), 0Ah, 0

align 16
src1 db 8 dup(11h), 8 dup(22h)
src2 db 8 dup(22h), 8 dup(11h)

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    movaps xmm0, xmmword ptr [src1]
    movaps xmm1, xmmword ptr [src2]
    punpckhbw xmm0, xmm1
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
  
    movaps xmm0, xmmword ptr [src1]
    movaps xmm1, xmmword ptr [src2]
    punpckhwd xmm0, xmm1
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
  
    movaps xmm0, xmmword ptr [src1]
    movaps xmm1, xmmword ptr [src2]
    punpckhdq xmm0, xmm1
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
  
    movaps xmm0, xmmword ptr [src1]
    movaps xmm1, xmmword ptr [src2]
    punpckhqdq xmm0, xmm1
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

    movaps xmm0, xmmword ptr [src1]
    movaps xmm1, xmmword ptr [src2]
    punpcklbw xmm0, xmm1
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
  
    movaps xmm0, xmmword ptr [src1]
    movaps xmm1, xmmword ptr [src2]
    punpcklwd xmm0, xmm1
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
  
    movaps xmm0, xmmword ptr [src1]
    movaps xmm1, xmmword ptr [src2]
    punpckldq xmm0, xmm1
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
  
    movaps xmm0, xmmword ptr [src1]
    movaps xmm1, xmmword ptr [src2]
    punpcklqdq xmm0, xmm1
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

    movaps xmm0, xmmword ptr [src1]
    movaps xmm1, xmmword ptr [src2]
    unpckhps xmm0, xmm1
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

    movapd xmm0, xmmword ptr [src1]
    movapd xmm1, xmmword ptr [src2]
    unpckhpd xmm0, xmm1
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

    movaps xmm0, xmmword ptr [src1]
    movaps xmm1, xmmword ptr [src2]
    unpcklps xmm0, xmm1
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

    movapd xmm0, xmmword ptr [src1]
    movapd xmm1, xmmword ptr [src2]
    unpcklpd xmm0, xmm1
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