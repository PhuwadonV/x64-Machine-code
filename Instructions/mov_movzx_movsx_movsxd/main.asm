includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format1 db 4 dup("%016llx", 0Ah), 0
format2 db "%016llx", 0Ah, 0

.code
main proc
    push rbx
    sub rsp, 32 + 16
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

    mov rcx, offset format1
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    mov r9, [rsp + 24]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov rdx, 1111111111111111h
    mov al, 88h

    movzx rdx, al

    mov rcx, offset format2
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov rdx, 1111111111111111h
    mov al, 88h

    movsx rdx, al

    mov rcx, offset format2
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov rdx, 1111111111111111h
    mov eax, 88888888h

    movsxd rdx, eax

    mov rcx, offset format2
    call printf

  ; ------------------------------
    add rsp, 32 + 16
    pop rbx
    xor eax, eax
    ret
main endp

end