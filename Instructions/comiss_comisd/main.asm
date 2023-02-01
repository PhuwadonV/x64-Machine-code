includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format db 3 dup("%02hhX "), 0Ah, 0

.code
main proc
    sub rsp, 40
  ; ------------------------------
  
    mov eax, 3F800000h ; 1.0
    mov ecx, 40000000h ; 2.0
    movd xmm0, eax
    movd xmm1, ecx
    comiss xmm0, xmm1

    setz dl
    setp r8b
    setc r9b

    mov rcx, offset format
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------
  
    mov rax, 3FF0000000000000h ; 1.0
    mov rcx, 3FF0000000000000h ; 1.0
    movq xmm0, rax
    movq xmm1, rcx
    comisd xmm0, xmm1

    setz dl
    setp r8b
    setc r9b

    mov rcx, offset format
    call printf

  ; ------------------------------
    add rsp, 40
    ret
main endp

end