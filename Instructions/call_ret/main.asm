includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
format db "%08x", 0

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    call procedure

    mov rcx, offset format
    mov edx, eax
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

procedure proc
    mov eax, 12345678h
    ret
procedure endp

end