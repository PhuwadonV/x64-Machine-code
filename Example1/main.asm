includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
format db "%d", 0

.code
main proc
    sub rsp, 40h
    xor rax, rax

  ; add rax, 123456789
    db 48h, 05h     
    dd 123456789

    mov rcx, offset format
    mov rdx, rax
    call printf

    add rsp, 40h
    xor eax, eax
    ret
main endp

end