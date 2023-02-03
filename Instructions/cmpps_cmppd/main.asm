includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format1 db 4 dup("%08x "), 0Ah, 0
format2 db 2 dup("%016llx "), 0Ah, 0

align 16
src1 dd 1.0f, 2.0f, 3.0f, 4.0f
src2 dd 1.0f, 4.0f, 3.0f, 2.0f
src3 dq 1.0, 2.0
src4 dq 1.0, 3.0

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    movapd xmm0, xmmword ptr [src1]
    movapd xmm1, xmmword ptr [src2]

    cmpps xmm0, xmm1, 0
  ; cmpeqps xmm0, xmm1
    movups [rsp + 8], xmm0
    mov eax, [rsp + 20]
    mov [rsp + 32], eax

    mov rcx, offset format1
    mov edx, [rsp + 8]
    mov r8d, [rsp + 12]
    mov r9d, [rsp + 16]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    movapd xmm0, [src3]
    movapd xmm1, [src4]

    cmppd xmm0, xmm1, 0
  ; cmpeqpd xmm0, xmm1
    movupd [rsp + 8], xmm0

    mov rcx, offset format2
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end