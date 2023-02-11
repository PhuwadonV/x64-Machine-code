includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto
GetCurrentThread proto
GetCurrentProcess proto
SetThreadAffinityMask proto
VirtualAllocEx proto
WaitForSingleObject proto
extern create_thread: proc

.const
separator db 30 dup("-"), 0Ah, 0
format1 db "Main   : %d %d", 0Ah, 0
format2 db "Main   : %lld", 0Ah, 0
format3 db "Thread : %d", 0Ah, 0

data segment align(64) 'DATA'
dst dd 16 dup(0h)
step dd ?
data ends

.code
main proc
    push rbx
    sub rsp, 32 + 16

    call GetCurrentThread

    mov rcx, rax
    mov rdx, 1
    call SetThreadAffinityMask
  ; ------------------------------

    call GetCurrentProcess

    mov rcx, rax
    xor edx, edx
    mov r8d, 256
    mov r9d, 1000h ; MEM_COMMIT
    mov dword ptr [rsp + 32], 404h ; PAGE_WRITECOMBINE | PAGE_READWRITE
    call VirtualAllocEx
    mov rbx, rax

    mov eax, [rbx] ; Commit

    rdtscp
    lfence
    mov r8d, eax
    mov r9d, edx

  ; ....................
    movntdqa xmm0, xmmword ptr [rbx]
    movntdqa xmm0, xmmword ptr [rbx + 64]
    movntdqa xmm0, xmmword ptr [rbx + 64 * 2]
    movntdqa xmm0, xmmword ptr [rbx + 64 * 3]
  ; movdqa xmm0, xmmword ptr [rbx]
  ; movdqa xmm0, xmmword ptr [rbx + 64]
  ; movdqa xmm0, xmmword ptr [rbx + 64 * 2]
  ; movdqa xmm0, xmmword ptr [rbx + 64 * 3]
  ; ....................

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
  ; ....................
    movnti [dst], ecx
  ; mov [dst], ecx
  ; ....................
    cmp ecx, 100000
    jne @b

    mov rcx, rbx
    mov rdx, 0FFFFFFFFh
    call WaitForSingleObject

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    clflush [dst]

  ; ....................
    movntdq xmmword ptr [dst], xmm0
  ; mov [dst], eax
  ; ....................

    rdtscp
    lfence
    mov r8d, eax
    mov r9d, edx

    mov eax, [dst]

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

  ; ....................
    movnti [dst], eax
  ; mov [dst], eax
  ; ....................

    rdtscp
    lfence
    mov r8d, eax
    mov r9d, edx

    mov eax, [dst]

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

  ; ....................
    movntps [dst], xmm0
  ; mov [dst], eax
  ; ....................

    rdtscp
    lfence
    mov r8d, eax
    mov r9d, edx

    mov eax, [dst]

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

  ; ....................
    movntpd xmmword ptr [dst], xmm0
  ; mov [dst], eax
  ; ....................

    rdtscp
    lfence
    mov r8d, eax
    mov r9d, edx

    mov eax, [dst]

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
    add rsp, 32 + 16
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

end