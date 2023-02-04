includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
GetCurrentThread proto
GetCurrentProcess proto
SetThreadAffinityMask proto
VirtualAllocEx proto
printf proto
WaitForSingleObject proto
extern create_thread: proc

.const
separator db 30 dup("-"), 0Ah, 0
format1 db "Main   : %d %d", 0Ah, 0
format2 db "Main   : %lld", 0Ah, 0
format3 db "Thread : %d", 0Ah, 0

.data
step dd ?

align 16
dst dd 4 dup(0h)

.code
main proc
    push rbx
    push rbp
    sub rsp, 32 + 16 + 8

    call GetCurrentThread

    mov dword ptr [rsp], 0

    mov rcx, rax
    mov rdx, [rsp]
    call SetThreadAffinityMask
  ; ------------------------------

    call GetCurrentProcess

    mov rcx, rax
    xor edx, edx
    mov r8d, 128
    mov r9d, 1000h
    mov dword ptr [rsp + 32], 404h
    call VirtualAllocEx
    mov rbp, rax

    mov [step], 0

    mov rcx, thread_wc
    mov rdx, rax
    call create_thread
    mov rbx, rax

    align 16
@@:
    cmp [step], 1
    jne @b

    align 16
@@:
    clflush [rbp]

    xor eax, eax
    cpuid

    mov eax, [rbp + 64]
    mfence

    movntdqa xmm0, xmmword ptr [rbp]
    movntdqa xmm1, xmmword ptr [rbp + 64]
  ; mov edx, [rbp]
  ; mov r8d, [rbp + 64]
    movd edx, xmm0
    movd r8d, xmm1

    test edx, edx
    jz @b

    mov [step], 2

    mov rcx, offset format1
    call printf

    mov rcx, rbx
    mov rdx, 0FFFFFFFFh
    call WaitForSingleObject

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov [step], 0

    mov rcx, thread_dst
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
  ; mov [dst], ecx
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
  ; mov [dst], eax

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

    mov rcx, offset format2
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
  ; mov [dst], eax

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

    mov rcx, offset format2
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
  ; mov [dst], eax

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

    mov rcx, offset format2
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
  ; mov [dst], eax

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

    mov rcx, offset format2
    mov rdx, rax
    call printf

  ; ------------------------------
    add rsp, 32 + 16 + 8
    pop rbp
    pop rbx
    xor eax, eax
    ret
main endp

thread_dst proc
    sub rsp, 32 + 8
  ; ------------------------------
    
    mov eax, [dst]
    mov [step], 1

    align 16
@@:
    mov edx, [dst]
    cmp edx, eax
    je @b

    mov rcx, offset format3
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
thread_dst endp

thread_wc proc
    sub rsp, 32 + 8
  ; ------------------------------

    xor eax, eax
    mov [step], 1
    
    align 16
@@:
    inc eax
    mov [rcx + 64], eax
    mov [rcx], eax
    cmp [step], 2
    jne @b

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
thread_wc endp

end