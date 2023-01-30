includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
format db "%d %u", 0Ah, "%d %u", 0

.code
main proc
    sub rsp, 40
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
    add rsp, 40
    xor eax, eax
    ret
main endp

end