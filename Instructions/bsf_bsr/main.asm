includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
format db 2 dup("%d "), 0

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    mov eax, 040000002h
    bsf edx, eax
    bsr r8d, eax

    mov rcx, offset format
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end