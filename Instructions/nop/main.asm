includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
format db "%lld", 0Ah, 0

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

start:
    nop

    mov rcx, offset format
    mov rdx, $ - start
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end