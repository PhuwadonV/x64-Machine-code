includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
format db 2 dup("%016llx "), 0Ah, 0

align 16
src1 dq 3333222211110000h, 7777666655554444h
src2 dq 0BBBBAAAA99998888h, 0FFFFEEEEDDDDCCCCh

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    movdqa xmm0, xmmword ptr [src1]
    movdqa xmm1, xmmword ptr [src2]
    palignr xmm0, xmm1, 8
    movupd [rsp + 8], xmm0

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