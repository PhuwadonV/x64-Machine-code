includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
format db 4 dup("%d "), 0Ah, 0

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    mov ebx, 1000
    mov ecx, 2

    lea edx, [ebx - 100]
    lea r8d, [ebx + ecx]
    lea r9d, [ebx * 2]
    lea ecx, [ebx + ecx * 4 + 100]

    mov [rsp + 32], ecx

    mov rcx, offset format
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end