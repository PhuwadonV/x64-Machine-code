includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format db 2 dup("%d "), 0Ah, 0

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    mov edx, 4
    mov r8d, 4

    shl edx, 1
    shr r8d, 1

    mov rcx, offset format
    mov [rsp + 32], eax
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov edx, -4
    mov r8d, -4

    sal edx, 1
    sar r8d, 1

    mov rcx, offset format
    mov [rsp + 32], eax
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end