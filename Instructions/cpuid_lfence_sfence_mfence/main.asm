includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto
GetCurrentThread proto
SetThreadAffinityMask proto
WaitForSingleObject proto
WaitForMultipleObjects proto
extern create_thread: proc

.const
separator db 30 dup("-"), 0Ah, 0
format db "%lld", 0Ah, 0

.data
step dd 0
dst dd (16 * 256) dup(0h)

data segment align(64) 'DATA'
turn dd 16 dup(0)
a_wants dd 16 dup(0)
b_wants dd 16 dup(0)
sum dd 16 dup(0)
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

    rdtsc
    mov r8d, eax
    mov r9d, edx

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

    mov rcx, thread_dst
    call create_thread
    mov rdx, rax

    align 16
@@:
    cmp [step], 1
    jne @b

    mov eax, 1
    mov rbx, offset dst
    xor ecx, ecx

    align 16
@@:
    movnti [rbx + rcx + 0], eax
    movnti [rbx + rcx + 4], eax
    movnti [rbx + rcx + 8], eax
    movnti [rbx + rcx + 12], eax
    add ecx, 16
    cmp ecx, 16384
    jne @b
    sfence
    mov [step], 2

    mov rcx, rdx
    mov rdx, 0FFFFFFFFh
    call WaitForSingleObject

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov [step], 0

    mov rcx, thread_a
    mov rdx, 1000000
    call create_thread
    mov [rsp + 32], rax

    mov rcx, thread_b
    mov rdx, 1000000
    call create_thread
    mov [rsp + 40], rax

    mov rcx, 2
    lea rdx, [rsp + 32]
    mov r8, 1
    mov r9d, 0FFFFFFFFh
    call WaitForMultipleObjects

    mov rcx, offset format
    mov edx, [sum]
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
    
    mov [step], 1

    align 16
@@:
    cmp [step], 2
    jne @b
    mov edx, [dst + 16380]

    mov rcx, offset format
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
thread_dst endp

thread_a proc
    sub rsp, 32 + 8
  ; ------------------------------
    
    align 16
get_lock:
    mov a_wants, 1
    mov turn, 1
    mfence

    align 16
@@:
    mov eax, [b_wants]
    mov edx, [turn]
    cmp eax, 1
    jne @f
    cmp edx, 1
    je @b
@@:
    add [sum], 1
    mov a_wants, 0
    dec ecx
    test ecx, ecx
    jnz get_lock

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
thread_a endp

thread_b proc
    sub rsp, 32 + 8
  ; ------------------------------

    align 16
get_lock:
    mov b_wants, 1
    mov turn, 0
    mfence

    align 16
@@:
    mov eax, [a_wants]
    mov edx, [turn]
    cmp eax, 1
    jne @f
    cmp edx, 0
    je @b
@@:
    add [sum], 1
    mov b_wants, 0
    dec ecx
    test ecx, ecx
    jnz get_lock

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
thread_b endp

end