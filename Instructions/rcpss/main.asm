includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
format db "%f", 0Ah, 0

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    mov eax, 40000000h ; 2.0f
    movd xmm0, eax
    rcpss xmm0, xmm0
    cvtss2sd xmm0, xmm0

    mov rcx, offset format
    movq rdx, xmm0
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end