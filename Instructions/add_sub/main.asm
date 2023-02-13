includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format db 2 dup("%d %u", 0Ah), 0

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    mov edx, 0FFFFFFFEh
    mov r8d, 0FFFFFFFEh
    mov r9d, edx
    mov eax, r8d

    add r9d, 1
    add eax, 1

    mov rcx, offset format
    mov [rsp + 32], eax
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov edx, 0FFFFFFFFh
    mov r8d, 0FFFFFFFFh
    mov r9d, edx
    mov eax, r8d

    sub r9d, 1
    sub eax, 1

    mov rcx, offset format
    mov [rsp + 32], eax
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end