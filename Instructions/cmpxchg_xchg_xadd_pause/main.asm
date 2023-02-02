includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto
CreateThread proto
Sleep proto
WaitForMultipleObjects proto

.const
separator db 30 dup("-"), 0Ah, 0
format1 db "Main : %d", 0Ah, 0
format2 db "Thread", 0Ah, 0

.data
align 16
@lock dd 4 dup(0h)
sum dd 4 dup(?)

.code
main proc
    sub rsp, 56
  ; ------------------------------

    mov [sum], 0

    mov rcx, thread_cmpxchg
    mov rdx, 500000
    call create_thread
    mov [rsp + 32], rax
     
    mov rcx, thread_cmpxchg
    mov rdx, 500000
    call create_thread
    mov [rsp + 40], rax

    mov rcx, 2
    lea rdx, [rsp + 32]
    mov r8, 1
    mov r9d, 0FFFFFFFFh
    call WaitForMultipleObjects

    mov rcx, offset format1
    mov edx, [sum]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov [sum], 0

    mov rcx, thread_xchg
    mov rdx, 500000
    call create_thread
    mov [rsp + 32], rax

    mov rcx, thread_xchg
    mov rdx, 500000
    call create_thread
    mov [rsp + 40], rax

    mov rcx, 2
    lea rdx, [rsp + 32]
    mov r8, 1
    mov r9d, 0FFFFFFFFh
    call WaitForMultipleObjects

    mov rcx, offset format1
    mov edx, [sum]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov [sum], 0

    mov rcx, thread_xadd
    mov rdx, 500000
    call create_thread
    mov [rsp + 32], rax

    mov rcx, thread_xadd
    mov rdx, 500000
    call create_thread
    mov [rsp + 40], rax

    mov rcx, 2
    lea rdx, [rsp + 32]
    mov r8, 1
    mov r9d, 0FFFFFFFFh
    call WaitForMultipleObjects

    mov rcx, offset format1
    mov edx, [sum]
    call printf

  ; ------------------------------
    add rsp, 56
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

thread_cmpxchg proc
    sub rsp, 40
  ; ------------------------------
    
    align 16
@@:
    pause
    mov eax, [sum]
    lea edx, [eax + 1]
    lock cmpxchg [sum], edx
    jne @b
    dec ecx
    test ecx, ecx
    jnz @b

    mov rcx, offset format2
    call printf

  ; ------------------------------
    add rsp, 40
    xor eax, eax
    ret
thread_cmpxchg endp

thread_xchg proc
    sub rsp, 40
  ; ------------------------------

    align 16
spin_lock:
    cmp [@lock], 0
    je get_lock
    pause
    jmp spin_lock
get_lock:
    mov eax, 1
    xchg [@lock], eax
  ; mov eax, [@lock]
  ; mov [@lock], 1
    cmp eax, 0
    jne spin_lock

    add [sum], 1
    mov [@lock], 0

    dec ecx
    test ecx, ecx
    jnz spin_lock

    mov rcx, offset format2
    call printf

  ; ------------------------------
    add rsp, 40
    xor eax, eax
    ret
thread_xchg endp

thread_xadd proc
    sub rsp, 40
  ; ------------------------------
    
    align 16
@@:
    pause
    mov eax, 1
    lock xadd [sum], eax
    dec ecx
    test ecx, ecx
    jnz @b

    mov rcx, offset format2
    call printf

  ; ------------------------------
    add rsp, 40
    xor eax, eax
    ret
thread_xadd endp

end