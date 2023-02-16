includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format1 db 4 dup("%08x "), 0Ah, 0
format2 db 4 dup("%016llx "), 0Ah, 0

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    mov al, 11h
    movd xmm0, eax
    vpbroadcastb xmm0, xmm0
    movdqu [rsp + 20], xmm0

    mov rcx, offset format1
    mov edx, [rsp + 20]
    mov r8d, [rsp + 24]
    mov r9d, [rsp + 28]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov ax, 1122h
    movd xmm0, eax
    vpbroadcastw xmm0, xmm0
    movdqu [rsp + 20], xmm0

    mov rcx, offset format1
    mov edx, [rsp + 20]
    mov r8d, [rsp + 24]
    mov r9d, [rsp + 28]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov eax, 11223344h
    movd xmm0, eax
    vpbroadcastd xmm0, xmm0
    movdqu [rsp + 20], xmm0

    mov rcx, offset format1
    mov edx, [rsp + 20]
    mov r8d, [rsp + 24]
    mov r9d, [rsp + 28]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov rax, 1122334455667788h
    movq xmm0, rax
    vpbroadcastq xmm0, xmm0
    movdqu [rsp + 20], xmm0

    mov rcx, offset format1
    mov edx, [rsp + 20]
    mov r8d, [rsp + 24]
    mov r9d, [rsp + 28]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov eax, 11223344h
    movd xmm0, eax
    vbroadcastss xmm0, xmm0
    movdqu [rsp + 20], xmm0

    mov rcx, offset format1
    mov edx, [rsp + 20]
    mov r8d, [rsp + 24]
    mov r9d, [rsp + 28]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov rax, 1122334455667788h
    movq xmm0, rax
    vbroadcastsd ymm0, xmm0
    vmovupd [rsp + 8], ymm0

    mov rcx, offset format2
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