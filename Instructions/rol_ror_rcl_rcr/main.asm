includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format db 2 dup("%08x "), 0Ah, 0

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    mov edx, 0FF000000h
    mov r8d, 0FFh

    rol edx, 8
    ror r8d, 8

    mov rcx, offset format
    mov [rsp + 32], eax
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov edx, 0
    mov r8d, 0

    stc
    rcl edx, 1
    stc
    rcr r8d, 1

    mov rcx, offset format
    mov [rsp + 32], eax
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end