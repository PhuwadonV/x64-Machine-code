includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format1 db 3 dup("%016llx", 0Ah), 0
format2 db "%016llx", 0Ah, 0

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    mov rdx, 1111111111111111h
    mov r8, rdx
    mov r9, rdx

    mov edx, 99999999h
    mov r8w, 9999h
    mov r9b, 99h

    mov rcx, offset format1
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov rdx, 1111111111111111h
    mov al, 99h

    movzx rdx, al

    mov rcx, offset format2
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov rdx, 1111111111111111h
    mov al, 99h

    movsx rdx, al

    mov rcx, offset format2
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov rdx, 1111111111111111h
    mov eax, 99999999h

    movsxd rdx, eax

    mov rcx, offset format2
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end