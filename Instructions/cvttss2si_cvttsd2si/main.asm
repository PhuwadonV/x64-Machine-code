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

    mov eax, 3FF33333h ; 1.9f
    movd xmm0, eax
    cvttss2si edx, xmm0

    mov rcx, offset format1
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov rax, 3FFE666666666666h ; 1.9
    movq xmm0, rax
    cvttsd2si rdx, xmm0

    mov rcx, offset format1
    call printf

  ; ------------------------------
    add rsp, 40
    ret
main endp

end