includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
GetCurrentThread proto
SetThreadAffinityMask proto
printf proto

.const
format db "%lld", 0Ah, 0
src dd 0h

.code
main proc
    sub rsp, 32 + 8

    call GetCurrentThread

    mov rcx, rax
    mov rdx, 1
    call SetThreadAffinityMask
  ; ------------------------------

    rdtscp
    mov r8d, eax
    mov r9d, edx

    pause

    rdtscp
    shl r9, 20h
    shl rdx, 20h
    or r8, r9
    or rax, rdx
    sub rax, r8

    mov rcx, offset format
    mov rdx, rax
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end