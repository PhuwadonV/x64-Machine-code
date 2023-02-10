includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format db 4 dup('%02hhX '), 0Ah, 0
src dd 12345678h

.code
main proc
    sub rsp, 32 + 8
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
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movbe eax, [src]

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
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end