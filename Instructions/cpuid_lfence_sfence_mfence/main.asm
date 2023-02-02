includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto
CreateThread proto
WaitForSingleObject proto

.const
separator db 30 dup("-"), 0Ah, 0
format db "%lld", 0Ah, 0

.data
step dd 0

align 16
dst dd 4096 dup(0h)

.code
main proc
    push rbx
    sub rsp, 32
  ; ------------------------------

    mov eax, 3
    mov ecx, 987654321
    cdq
    div ecx
    div ecx
    div ecx
    div ecx
    div ecx
    div ecx
    div ecx
    div ecx

    xor eax, eax
    cpuid

    rdtsc
    mov r8d, eax
    mov r9d, edx

    lfence

    rdtsc
    shl r9, 20h
    shl rdx, 20h
    or r8, r9
    or rax, rdx
    sub rax, r8

    mov rcx, offset format
    mov rdx, rax
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    xor eax, eax
    cpuid

    rdtsc
    mov r8d, eax
    mov r9d, edx

    lfence

    mov eax, 123456
    mov ecx, 654321
    cdq
    div ecx

    lfence

    rdtsc
    shl r9, 20h
    shl rdx, 20h
    or r8, r9
    or rax, rdx
    sub rax, r8

    mov rcx, offset format
    mov rdx, rax
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov rcx, thread
    call create_thread
    mov rbx, rax

    align 16
@@:
    cmp [step], 1
    jne @b

    mov eax, 1
    mov rbx, offset dst
    xor ecx, ecx

    align 16
@@:
    movnti [rbx + rcx], eax
    add ecx, 4
    cmp ecx, 16384
    jne @b
    sfence
    mov [step], 2

    mov rcx, rbx
    mov rdx, 0FFFFFFFFh
    call WaitForSingleObject

  ; ------------------------------
    add rsp, 32
    pop rbx
    xor eax, eax
    ret
main endp

create_thread proc
    sub rsp, 56
  ; ------------------------------

    mov r8, rcx
    mov r9, rdx
    lea rax, [rsp + 48]

    xor ecx, ecx
    xor edx, edx
    mov [rsp + 32], ecx
    mov [rsp + 40], rax
    call CreateThread

  ; ------------------------------
    add rsp, 56
    ret
create_thread endp

thread proc
    sub rsp, 40
  ; ------------------------------
    
    mov [step], 1

    align 16
@@:
    cmp [step], 2
    jne @b
    mov edx, [dst + 16380]

    mov rcx, offset format
    call printf

  ; ------------------------------
    add rsp, 40
    xor eax, eax
    ret
thread endp


end