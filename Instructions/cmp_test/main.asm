includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format db 2 dup("%08x "), 0Ah, 0

.code
main proc
    sub rsp, 40
  ; ------------------------------

    mov eax, 1

    pushfq
    cmp eax, 1

    pushfq
    mov rdx, [rsp]
    popfq
    popfq

    pushfq
    sub eax, 1

    pushfq
    mov r8, [rsp]
    popfq
    popfq

    mov rcx, offset format
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov eax, 1

    pushfq
    test eax, 1

    pushfq
    mov rdx, [rsp]
    popfq
    popfq

    pushfq
    and eax, 1

    pushfq
    mov r8, [rsp]
    popfq
    popfq

    mov rcx, offset format
    call printf

  ; ------------------------------
    add rsp, 40
    xor eax, eax
    ret
main endp

end