includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format db "%016llx", 0Ah, 0

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    xor eax, eax
    mov al, 0FFh
    cbw

    mov rcx, offset format
    mov rdx, rax
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    xor eax, eax
    mov ax, 0FFFFh
    cwde

    mov rcx, offset format
    mov rdx, rax
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    xor eax, eax
    mov eax, 0FFFFFFFFh
    cdqe

    mov rcx, offset format
    mov rdx, rax
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end