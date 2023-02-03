includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
format db "%llu", 0Ah ,"%llu", 0

.data
dst db 4 dup(0FFh), 4 dup(0h)

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    mov rdx, qword ptr [dst]
    add rdx, rdx

    add byte ptr [dst + 0], 0FFh
    adc byte ptr [dst + 1], 0FFh
    adc byte ptr [dst + 2], 0FFh
    adc byte ptr [dst + 3], 0FFh
    adc byte ptr [dst + 4], 0h
    adc byte ptr [dst + 5], 0h
    adc byte ptr [dst + 6], 0h
    adc byte ptr [dst + 7], 0h

    mov rcx, offset format
    mov r8, qword ptr [dst]
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end