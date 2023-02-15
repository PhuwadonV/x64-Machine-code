includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format db "%f", 0Ah, 0

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    mov eax, 3FC00000h ; 1.5f
    movd xmm0, eax
    roundss xmm0, xmm0, 0h
    cvtss2sd xmm0, xmm0

    mov rcx, offset format
    movq rdx, xmm0
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov rax, 3FF8000000000000h ; 1.5f
    movq xmm0, rax
    roundsd xmm0, xmm0, 0h

    mov rcx, offset format
    movq rdx, xmm0
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end