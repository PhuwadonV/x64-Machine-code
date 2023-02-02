includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format1 db "%d", 0Ah, 0
format2 db "%08x", 0Ah, 0
format3 db "%f", 0Ah, 0

.code
main proc
    sub rsp, 40
  ; ------------------------------

    mov eax, 1
    cvtsi2ss xmm0, eax
    movd edx, xmm0

    mov rcx, offset format2
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov rax, 1
    cvtsi2sd xmm0, rax
    movd rdx, xmm0

    mov rcx, offset format3
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov eax, 3F800000h ; 1.0f
    movd xmm0, eax
    cvtss2si edx, xmm0

    mov rcx, offset format1
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov eax, 3F800000h ; 1.0f
    movd xmm0, eax
    cvtss2sd xmm0, xmm0
    movd rdx, xmm0

    mov rcx, offset format3
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov rax, 3FF0000000000000h ; 1.0
    movq xmm0, rax
    cvtsd2si rdx, xmm0

    mov rcx, offset format1
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov rax, 3FF0000000000000h ; 1.0
    movq xmm0, rax
    cvtsd2ss xmm0, xmm0
    movd edx, xmm0

    mov rcx, offset format2
    call printf

  ; ------------------------------
    add rsp, 40
    xor eax, eax
    ret
main endp

end