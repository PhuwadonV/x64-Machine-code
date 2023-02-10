includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format db "%d", 0Ah, 0

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
    mov rcx, offset separator
    call printf
  ; ------------------------------

    xor edx, edx

    mov eax, 1
    cmp eax, 1
    sete dl

    mov rcx, offset format
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end