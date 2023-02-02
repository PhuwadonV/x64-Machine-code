includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format db "%d", 0Ah, 0

.code
main proc
    sub rsp, 40
  ; ------------------------------

    xor edx, edx
    inc edx

    mov rcx, offset format
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    xor edx, edx
    dec edx

    mov rcx, offset format
    call printf

  ; ------------------------------
    add rsp, 40
    xor eax, eax
    ret
main endp

end