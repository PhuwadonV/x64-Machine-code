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

    mov eax, 3F800000h ; 1.0f
    mov ecx, 40000000h ; 2.0f
    movd xmm0, eax
    movd xmm1, ecx
    minss xmm0, xmm1
    cvtss2sd xmm0, xmm0

    mov rcx, offset format
    movq rdx, xmm0
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov rax, 3FF0000000000000h ; 1.0
    mov rcx, 4000000000000000h ; 2.0
    movq xmm0, rax
    movq xmm1, rcx
    minsd xmm0, xmm1

    mov rcx, offset format
    movq rdx, xmm0
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov eax, 3F800000h ; 1.0f
    mov ecx, 40000000h ; 2.0f
    movd xmm0, eax
    movd xmm1, ecx
    maxss xmm0, xmm1
    cvtss2sd xmm0, xmm0

    mov rcx, offset format
    movq rdx, xmm0
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov rax, 3FF0000000000000h ; 1.0
    mov rcx, 4000000000000000h ; 2.0
    movq xmm0, rax
    movq xmm1, rcx
    maxsd xmm0, xmm1

    mov rcx, offset format
    movq rdx, xmm0
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end