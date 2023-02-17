includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format1 db 4 dup("%08x "), 0Ah, 0

align 16
src1 db 16 dup(40h)
src2 dw 8 dup(4000h)
src3 db 16 dup(80h)
src4 dw 8 dup(8000h)
src5 db 16 dup(0C0h)
src6 dw 8 dup(0C000h)
src7 db 16 dup(40h)
src8 dw 8 dup(4000h)

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    movdqa xmm0, xmmword ptr [src1]
    paddsb xmm0, xmm0
    movdqu [rsp + 20], xmm0

    mov rcx, offset format1
    mov edx, [rsp + 20]
    mov r8d, [rsp + 24]
    mov r9d, [rsp + 28]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------
  
    movdqa xmm0, xmmword ptr [src2]
    paddsw xmm0, xmm0
    movdqu [rsp + 20], xmm0

    mov rcx, offset format1
    mov edx, [rsp + 20]
    mov r8d, [rsp + 24]
    mov r9d, [rsp + 28]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------
  
    movdqa xmm0, xmmword ptr [src3]
    paddusb xmm0, xmm0
    movdqu [rsp + 20], xmm0

    mov rcx, offset format1
    mov edx, [rsp + 20]
    mov r8d, [rsp + 24]
    mov r9d, [rsp + 28]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------
  
    movdqa xmm0, xmmword ptr [src4]
    paddusw xmm0, xmm0
    movdqu [rsp + 20], xmm0

    mov rcx, offset format1
    mov edx, [rsp + 20]
    mov r8d, [rsp + 24]
    mov r9d, [rsp + 28]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movdqa xmm0, xmmword ptr [src5]
    movdqa xmm1, xmmword ptr [src1]
    psubsb xmm0, xmm1
    movdqu [rsp + 20], xmm0

    mov rcx, offset format1
    mov edx, [rsp + 20]
    mov r8d, [rsp + 24]
    mov r9d, [rsp + 28]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------
  
    movdqa xmm0, xmmword ptr [src6]
    movdqa xmm1, xmmword ptr [src2]
    psubsw xmm0, xmm1
    movdqu [rsp + 20], xmm0

    mov rcx, offset format1
    mov edx, [rsp + 20]
    mov r8d, [rsp + 24]
    mov r9d, [rsp + 28]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------
  
    movdqa xmm0, xmmword ptr [src7]
    movdqa xmm1, xmmword ptr [src3]
    psubusb xmm0, xmm1
    movdqu [rsp + 20], xmm0

    mov rcx, offset format1
    mov edx, [rsp + 20]
    mov r8d, [rsp + 24]
    mov r9d, [rsp + 28]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------
  
    movdqa xmm0, xmmword ptr [src8]
    movdqa xmm1, xmmword ptr [src4]
    psubusw xmm0, xmm1
    movdqu [rsp + 20], xmm0

    mov rcx, offset format1
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