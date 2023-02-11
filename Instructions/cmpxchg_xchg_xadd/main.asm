includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto
Sleep proto
WaitForMultipleObjects proto
extern create_thread: proc

.const
separator db 30 dup("-"), 0Ah, 0
format1 db "Main : %d", 0Ah, 0
format2 db "Thread", 0Ah, 0

data segment align(64) 'DATA'
@lock dd 16 dup(0h)
sum dd 16 dup(?)
data ends

.code
main proc
    sub rsp, 32 + 16 + 8
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
    add rsp, 32 + 16 + 8
    xor eax, eax
    ret
main endp

thread_cmpxchg proc
    sub rsp, 32 + 8
  ; ------------------------------
    
    align 16
@@:
    pause
    mov eax, [sum]
    lea edx, [eax + 1]
  ; ....................
    lock cmpxchg [sum], edx
  ; cmpxchg [sum], edx
  ; ....................
    jne @b
    sub ecx, 1
    jnz @b

    mov rcx, offset format2
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
thread_cmpxchg endp

thread_xchg proc
    sub rsp, 32 + 8
  ; ------------------------------

    align 16
spin_lock:
    test [@lock], 0
    jz get_lock
    pause
    jmp spin_lock
get_lock:
    mov eax, 1
  ; ....................
    xchg [@lock], eax
  ; mov eax, [@lock]
  ; mov [@lock], 1
  ; ....................
    test eax, eax
    jne spin_lock

    add [sum], 1
    mov [@lock], 0

    sub ecx, 1
    jnz spin_lock

    mov rcx, offset format2
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
thread_xchg endp

thread_xadd proc
    sub rsp, 32 + 8
  ; ------------------------------
    
    align 16
@@:
    pause
    mov eax, 1

  ; ....................
    lock xadd [sum], eax
  ; xadd [sum], eax
  ; ....................

    sub ecx, 1 
    jnz @b

    mov rcx, offset format2
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
thread_xadd endp

end