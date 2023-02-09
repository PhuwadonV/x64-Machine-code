includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

const segment align(64) 'CONST'
cacheLine1 dq 8 dup(1)
cacheLine2 dq 8 dup(2)
const ends

.const
format db 2 dup("%llu", 0Ah), 0

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    lddqu xmm0, xmmword ptr [cacheLine1 + 56]
    movdqu [rsp + 8], xmm0

    mov rcx, offset format
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end