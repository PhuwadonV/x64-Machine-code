includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
format db 4 dup("%llx", 0Ah), 0

.code
main proc
    push rbx
    sub rsp, 48
  ; ------------------------------

    xor eax, eax
    add rax, 0FFFFFFFFFFFFFFFFh ; add rax, sign-entended imm8
    mov rcx, rax
    mov rdx, rax
    mov rbx, rax

    mov ecx, 0
    mov dx, 0
    mov bl, 0

    mov [rsp + 8], rax
    mov [rsp + 16], rcx
    mov [rsp + 24], rdx
    mov [rsp + 32], rbx

    mov rcx, offset format
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    mov r9, [rsp + 24]
    call printf

  ; ------------------------------
    add rsp, 48
    pop rbx
    xor eax, eax
    ret
main endp

end