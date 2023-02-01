includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format1 db 2 dup("%d "), 0Ah, 0

.code
main proc
    sub rsp, 40
  ; ------------------------------

    mov eax, 5
    mov ecx, 2

    cdq
    div ecx

    mov rcx, offset format1
    mov r8d, eax
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov rax, -5
    mov rcx, 2

    cqo
    idiv rcx

    mov rcx, offset format1
    mov r8d, eax
    call printf

  ; ------------------------------
    add rsp, 40
    xor eax, eax
    ret
main endp

end