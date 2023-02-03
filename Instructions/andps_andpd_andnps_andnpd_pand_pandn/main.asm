includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format db 4 dup("%08x "), 0Ah, 0

align 16
src db 16 dup(0FFh)
@mask db 8 dup(0FFh, 0h)

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    movdqa xmm0, xmmword ptr [@mask]
    movdqa xmm1, xmmword ptr [src]
    pand xmm0, xmm1
    movdqu [rsp + 8], xmm0
    mov eax, [rsp + 20]

    mov rcx, offset format
    mov edx, [rsp + 8]
    mov r8d, [rsp + 12]
    mov r9d, [rsp + 16]
    mov [rsp + 32], eax
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movaps xmm0, xmmword ptr [@mask]
    movaps xmm1, xmmword ptr [src]
    andps xmm0, xmm1
    movups [rsp + 8], xmm0
    mov eax, [rsp + 20]

    mov rcx, offset format
    mov edx, [rsp + 8]
    mov r8d, [rsp + 12]
    mov r9d, [rsp + 16]
    mov [rsp + 32], eax
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movapd xmm0, xmmword ptr [@mask]
    movapd xmm1, xmmword ptr [src]
    andpd xmm0, xmm1
    movupd [rsp + 8], xmm0
    mov eax, [rsp + 20]

    mov rcx, offset format
    mov edx, [rsp + 8]
    mov r8d, [rsp + 12]
    mov r9d, [rsp + 16]
    mov [rsp + 32], eax
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movdqa xmm0, xmmword ptr [@mask]
    movdqa xmm1, xmmword ptr [src]
    pandn xmm0, xmm1
    movdqu [rsp + 8], xmm0
    mov eax, [rsp + 20]

    mov rcx, offset format
    mov edx, [rsp + 8]
    mov r8d, [rsp + 12]
    mov r9d, [rsp + 16]
    mov [rsp + 32], eax
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movaps xmm0, xmmword ptr [@mask]
    movaps xmm1, xmmword ptr [src]
    andnps xmm0, xmm1
    movups [rsp + 8], xmm0
    mov eax, [rsp + 20]

    mov rcx, offset format
    mov edx, [rsp + 8]
    mov r8d, [rsp + 12]
    mov r9d, [rsp + 16]
    mov [rsp + 32], eax
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movapd xmm0, xmmword ptr [@mask]
    movapd xmm1, xmmword ptr [src]
    andnpd xmm0, xmm1
    movupd [rsp + 8], xmm0
    mov eax, [rsp + 20]

    mov rcx, offset format
    mov edx, [rsp + 8]
    mov r8d, [rsp + 12]
    mov r9d, [rsp + 16]
    mov [rsp + 32], eax
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end