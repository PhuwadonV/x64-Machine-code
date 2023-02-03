includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format1 db "%016llx", 0Ah, 0
format2 db "%d", 0Ah, 0
src db 8 dup(0FFh)

.data
dst db 8 dup(?)

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    std
    mov ecx, 4
    mov rsi, offset src + 7
    mov rdi, offset dst + 7
    rep movsb

    mov rcx, offset format1
    mov rdx, qword ptr [dst]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    cld
    mov eax, 11h
    mov ecx, 4
    mov rdi, offset dst
    rep stosb

    mov rcx, offset format1
    mov rdx, qword ptr [dst]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    xor edx, edx

    std
    mov ecx, 4
    mov rsi, offset src + 7
    mov rdi, offset dst + 7
    repe cmpsb

    mov rcx, offset format2
    sete dl
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    xor edx, edx

    cld
    mov eax, 11h
    mov ecx, 4
    mov rdi, offset dst
    repe scasb

    mov rcx, offset format2
    sete dl
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end