includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format db "%llu", 0Ah ,"%llu", 0Ah, 0

.data
dst1 db 4 dup(0FFh), 4 dup(0h)
dst2 db 4 dup(0FFh), 4 dup(0h)

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    mov rdx, qword ptr [dst1]
    add rdx, rdx

    add byte ptr [dst1 + 0], 0FFh
    adc byte ptr [dst1 + 1], 0FFh
    adc byte ptr [dst1 + 2], 0FFh
    adc byte ptr [dst1 + 3], 0FFh
    adc byte ptr [dst1 + 4], 0h
    adc byte ptr [dst1 + 5], 0h
    adc byte ptr [dst1 + 6], 0h
    adc byte ptr [dst1 + 7], 0h

    mov rcx, offset format
    mov r8, qword ptr [dst1]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov rdx, qword ptr [dst2]
    sub rdx, rdx

    sub byte ptr [dst2 + 0], 0FFh
    sbb byte ptr [dst2 + 1], 0FFh
    sbb byte ptr [dst2 + 2], 0FFh
    sbb byte ptr [dst2 + 3], 0FFh
    sbb byte ptr [dst2 + 4], 0h
    sbb byte ptr [dst2 + 5], 0h
    sbb byte ptr [dst2 + 6], 0h
    sbb byte ptr [dst2 + 7], 0h

    mov rcx, offset format
    mov r8, qword ptr [dst2]
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end