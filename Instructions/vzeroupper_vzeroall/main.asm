includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

const segment align(64) 'CONST'
src dd 16 dup(0FFFFFFFFh)
const ends

.const
separator db 30 dup("-"), 0Ah, 0
format db 4 dup("%016llx "), 0Ah, 0

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    vmovdqa ymm0, ymmword ptr [src]
    vzeroupper
    vmovdqu ymmword ptr [rsp + 8], ymm0

    mov rcx, offset format
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    mov r9, [rsp + 24]
    vzeroupper
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    vmovdqa ymm0, ymmword ptr [src]
    vzeroall
    vmovdqu ymmword ptr [rsp + 8], ymm0

    mov rcx, offset format
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    mov r9, [rsp + 24]
    vzeroupper
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end