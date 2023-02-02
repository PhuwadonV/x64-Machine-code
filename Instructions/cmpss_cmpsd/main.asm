includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format1 db "%08x", 0Ah, 0
format2 db "%016llx", 0Ah, 0

align 16
src1 dd 1.0f

.code
main proc
    sub rsp, 40
  ; ------------------------------

    mov eax, 3F800000h ; 1.0f
    movd xmm0, eax
    movd xmm1, eax

    cmpss xmm0, xmm1, 0
  ; cmpeqss xmm0, xmm1
    movups [rsp + 8], xmm0

    mov rcx, offset format1
    mov edx, [rsp + 8]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov rax, 3FF0000000000000h ; 1.0
    movq xmm0, rax
    movq xmm1, rax

    cmpsd xmm0, xmm1, 0
  ; cmpeqsd xmm0, xmm1
    movupd [rsp + 8], xmm0

    mov rcx, offset format2
    mov rdx, [rsp + 8]
    call printf

  ; ------------------------------
    add rsp, 40
    ret
main endp

end