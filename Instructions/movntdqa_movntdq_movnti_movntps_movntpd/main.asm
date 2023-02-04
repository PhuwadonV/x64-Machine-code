includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
GetCurrentThread proto
SetThreadAffinityMask proto
printf proto
WaitForSingleObject proto
extern create_thread: proc

.const
separator db 30 dup("-"), 0Ah, 0
format1 db "Main   : %lld", 0Ah, 0
format2 db "Thread : %d", 0Ah, 0

.data
step dd 0

align 16
dst dd 4 dup(0h)

.code
main proc
    sub rsp, 32 + 8

    call GetCurrentThread
    mov rbx, rax

    mov dword ptr [rsp], 0

    mov rcx, rax
    mov rdx, [rsp]
    call SetThreadAffinityMask
  ; ------------------------------

    clflush [dst]

    xor eax, eax
    cpuid

    movntdqa xmm0, xmmword ptr [dst]

    xor eax, eax
    cpuid

    rdtscp
    mov r8d, eax
    mov r9d, edx

    lfence
    mov eax, [dst]
    mfence

    rdtscp
    shl r9, 20h
    shl rdx, 20h
    or r8, r9
    or rax, rdx
    sub rax, r8

    mov rcx, offset format1
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

    xor ecx, ecx
    align 16
@@:
    inc ecx
    movnti [dst], ecx
    cmp ecx, 10000
    jne @b 

    mov rcx, rbx
    mov rdx, 0FFFFFFFFh
    call WaitForSingleObject

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    clflush [dst]

    xor eax, eax
    cpuid

    movntdq xmmword ptr [dst], xmm0

    xor eax, eax
    cpuid

    rdtscp
    mov r8d, eax
    mov r9d, edx

    lfence
    mov eax, [dst]
    mfence

    rdtscp
    shl r9, 20h
    shl rdx, 20h
    or r8, r9
    or rax, rdx
    sub rax, r8

    mov rcx, offset format1
    mov rdx, rax
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    clflush [dst]

    xor eax, eax
    cpuid

    movnti [dst], eax

    xor eax, eax
    cpuid

    rdtscp
    mov r8d, eax
    mov r9d, edx

    lfence
    mov eax, [dst]
    mfence

    rdtscp
    shl r9, 20h
    shl rdx, 20h
    or r8, r9
    or rax, rdx
    sub rax, r8

    mov rcx, offset format1
    mov rdx, rax
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    clflush [dst]

    xor eax, eax
    cpuid

    movntps [dst], xmm0

    xor eax, eax
    cpuid

    rdtscp
    mov r8d, eax
    mov r9d, edx

    lfence
    mov eax, [dst]
    mfence

    rdtscp
    shl r9, 20h
    shl rdx, 20h
    or r8, r9
    or rax, rdx
    sub rax, r8

    mov rcx, offset format1
    mov rdx, rax
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    clflush [dst]

    xor eax, eax
    cpuid

    movntpd xmmword ptr [dst], xmm0

    xor eax, eax
    cpuid

    rdtscp
    mov r8d, eax
    mov r9d, edx

    lfence
    mov eax, [dst]
    mfence

    rdtscp
    shl r9, 20h
    shl rdx, 20h
    or r8, r9
    or rax, rdx
    sub rax, r8

    mov rcx, offset format1
    mov rdx, rax
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

thread proc
    sub rsp, 32 + 8
  ; ------------------------------
    
    mov eax, [dst]
    mov [step], 1

    align 16
@@:
    mov edx, [dst]
    cmp edx, eax
    je @b

    mov rcx, offset format2
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
thread endp

end