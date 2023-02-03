includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
format db 2 dup("%x "), 2 dup("%d "), 0

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    mov edx, 2
    mov r8d, 2
    mov r9d, -4
    mov eax, -4

    shl edx, 1
    shr r8d, 1
    sal r9d, 1
    sar eax, 1

    mov rcx, offset format
    mov [rsp + 32], eax
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end