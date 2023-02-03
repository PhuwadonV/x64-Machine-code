includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
format db "%d", 0

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    xor edx, edx

    mov eax, 1
    cmp eax, 1
    cmove edx, eax

    mov rcx, offset format
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end