includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

@adc1 equ adcx
@adc2 equ adox
; @adc1 equ adc
; @adc2 equ adc

.const
format db 3 dup("%llx "), 0Ah, 3 dup("%llx "), 0
max dq 0FFFFFFFFFFFFFFFFh
zero dq 0h

.code
main proc
    push r10
    push r11
    push r12
    sub rsp, 32 + 16 * 3
  ; ------------------------------

    mov rdx, [max]
    mov r8,  [max]
    mov r9,  [zero]

    mov r10, [max]
    mov r11, [max]
    mov r12, [zero]

    xor rax, rax
    
    @adc1 rdx, [max]
    @adc2 r10, [max]

    @adc1 r8,  [max]
    @adc2 r11, [max]

    @adc1 r9,  [zero]
    @adc2 r12, [zero]

    mov rcx, offset format
    mov [rsp + 32], r10
    mov [rsp + 40], r11
    mov [rsp + 48], r12
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