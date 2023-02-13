includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

@adc1 equ adcx
@adc2 equ adox
; @adc1 equ adc
; @adc2 equ adc

.const
format db 3 dup("%016llx "), 0Ah, 3 dup("%016llx "), 0
max dq 0FFFFFFFFFFFFFFFFh
zero dq 0h

.code
main proc
    push rbx
    push rsi
    push rdi
    sub rsp, 32 + 16 * 3
  ; ------------------------------

    mov rdx, [max]
    mov r8,  [max]
    mov r9,  [zero]

    mov rbx, [max]
    mov rsi, [max]
    mov rdi, [zero]

    xor rax, rax
    
    @adc1 rdx, [max]
    @adc2 rbx, [max]

    @adc1 r8,  [max]
    @adc2 rsi, [max]

    @adc1 r9,  [zero]
    @adc2 rdi, [zero]

    mov rcx, offset format
    mov [rsp + 32], rbx
    mov [rsp + 40], rsi
    mov [rsp + 48], rdi
    call printf

  ; ------------------------------
    add rsp, 32 + 16 * 3
    pop r12
    pop r11
    pop r10
    xor eax, eax
    ret
main endp

end