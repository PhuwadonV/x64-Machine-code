includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format db "%f", 0Ah, 00

.code
main proc
    sub rsp, 40
  ; ------------------------------

    mov eax, 3F800000h ; 1.0f
    movd xmm0, eax
    addss xmm0, xmm0
    cvtss2sd xmm0, xmm0

    mov rcx, offset format
    movd rdx, xmm0
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov rax, 3FF0000000000000h ; 1.0
    movq xmm0, rax
    addsd xmm0, xmm0

    mov rcx, offset format
    movd rdx, xmm0
    call printf

  ; ------------------------------
    add rsp, 40
    xor eax, eax
    ret
main endp

end