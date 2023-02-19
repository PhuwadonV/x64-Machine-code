includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format db 4 dup("%02hhx "), 0Ah, 0

.code
main proc
    sub rsp, 32 + 16 * 2 +8
  ; ------------------------------

    stmxcsr [rsp + 32]
    and byte ptr [rsp + 32], 0FFFFFFFEh
    ldmxcsr [rsp + 32]
  
    mov eax, 3F800000h ; 1.0f
    mov ecx, 40000000h ; 2.0f
    movd xmm0, eax
    movd xmm1, ecx
    comiss xmm0, xmm1

    stmxcsr [rsp + 32]

    setz dl
    setp r8b
    setc r9b
    and byte ptr [rsp + 32], 1

    mov rcx, offset format
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    stmxcsr [rsp + 32]
    and byte ptr [rsp + 32], 0FFFFFFFEh
    ldmxcsr [rsp + 32]
  
    mov rax, 3FF0000000000000h ; 1.0
    mov rcx, 3FF0000000000000h ; 1.0
    movq xmm0, rax
    movq xmm1, rcx
    comisd xmm0, xmm1

    stmxcsr [rsp + 32]

    setz dl
    setp r8b
    setc r9b
    and byte ptr [rsp + 32], 1

    mov rcx, offset format
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    stmxcsr [rsp + 32]
    and byte ptr [rsp + 32], 0FFFFFFFEh
    ldmxcsr [rsp + 32]

    mov eax, 3F800000h ; 1.0f
    mov ecx, 0FFFFFFFFh ; QNaN
    movd xmm0, eax
    movd xmm1, ecx
    ucomiss xmm0, xmm1

    stmxcsr [rsp + 32]

    setz dl
    setp r8b
    setc r9b
    and byte ptr [rsp + 32], 1

    mov rcx, offset format
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    stmxcsr [rsp + 32]
    and byte ptr [rsp + 32], 0FFFFFFFEh
    ldmxcsr [rsp + 32]
  
    mov rax, 3FF0000000000000h ; 1.0
    mov rcx, 0FFFFFFFFFFFFFFFFh ; QNaN
    movq xmm0, rax
    movq xmm1, rcx
    ucomisd xmm0, xmm1

    stmxcsr [rsp + 32]

    setz dl
    setp r8b
    setc r9b
    and byte ptr [rsp + 32], 1

    mov rcx, offset format
    call printf

  ; ------------------------------
    add rsp, 32 + 16 * 2 + 8
    xor eax, eax
    ret
main endp

end