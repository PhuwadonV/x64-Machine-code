includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format db "%lld", 0Ah, "Carry: %d", 0Ah, "Overflow: %d", 0Ah, 0

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    xor eax, eax
    xor r8, r8
    xor r9, r9

    mov edx, 2
    mov eax, 0FFFFFFFFh
    mul edx
    mov [rsp + 8], eax
    mov [rsp + 12], edx

    mov rcx, offset format
    mov rdx, [rsp + 8]
    setc r8b
    seto r9b
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    xor eax, eax
    xor r8, r8
    xor r9, r9

    mov edx, 2
    mov eax, 0FFFFFFFFh
    mulx edx, eax, eax
    mov [rsp + 8], eax
    mov [rsp + 12], edx

    mov rcx, offset format
    mov rdx, [rsp + 8]
    setc r8b
    seto r9b
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    xor eax, eax
    xor r8, r8
    xor r9, r9

    mov edx, 2
    mov eax, 0FFFFFFFFh
    imul edx
    mov [rsp + 8], eax
    mov [rsp + 12], edx

    mov rcx, offset format
    mov rdx, [rsp + 8]
    setc r8b
    seto r9b
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end