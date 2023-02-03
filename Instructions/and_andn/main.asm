includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format db "%08x", 0Ah, 0

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    mov edx, 0FFFFFFFFh
    mov r8d, 0F0F0F0F0h
    and edx, r8d

    mov rcx, offset format
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov edx, 0FFFFFFFFh
    mov r8d, 0F0F0F0F0h
    andn edx, r8d, edx

    mov rcx, offset format
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end