includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
format db 4 dup('%02hhX '), 0

.code
main proc
    sub rsp, 40
  ; ------------------------------

    mov eax, 12345678h
    bswap eax

    mov dl, al
    shr eax, 8
    mov r8b, al
    shr eax, 8
    mov r9b, al
    shr eax, 8
    mov [rsp + 32], al

    mov rcx, offset format
    call printf

  ; ------------------------------
    add rsp, 40
    xor eax, eax
    ret
main endp

end