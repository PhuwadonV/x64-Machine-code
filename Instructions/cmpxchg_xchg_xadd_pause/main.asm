includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto
CreateThread proto
Sleep proto
WaitForSingleObject proto

.const
separator db 30 dup("-"), 0Ah, 0
format1 db "Main    : ", 2 dup("%08x "), 0Ah, 0
format2 db "Thread 1: ", 2 dup("%08x "), 0Ah, 0
format3 db "Main: ", 0Ah, 0
format4 db "Thread", 0Ah, 0

.data
dwThreadId1 dd ?
dwThreadId2 dd ?

align 16
@lock db 16 dup(0h) 

.code
main proc
    push rbx
    sub rsp, 32
  ; ------------------------------

    mov rcx, thread1
    call create_thread
    mov rbx, rax

    rdrand ecx
    and ecx, 1
    shl ecx, 26
    inc ecx
@@:
    loop @b

    xor eax, eax
    align 16
@@:
    pause
    lea edx, [eax + 1]
    lock cmpxchg dword ptr [@lock], edx
    jne @b

    mov rcx, offset format1
    mov edx, eax
    mov r8d, dword ptr [@lock]
    call printf

    mov rcx, rbx
    mov rdx, 0FFFFFFFFh
    call WaitForSingleObject

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov [@lock], 1

    mov rcx, thread2
    call create_thread
    mov rbx, rax

spin_lock:
    cmp [@lock], 0
    je get_lock
    pause
    jmp spin_lock
get_lock:
    mov eax, 1
    xchg dword ptr [@lock], eax
    cmp eax, 0
    jne spin_lock

    mov rcx, offset format3
    call printf

    mov [@lock], 0

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
    lea rax, [rsp + 48]

    xor ecx, ecx
    xor edx, edx
    xor r9, r9
    mov [rsp + 32], ecx
    mov [rsp + 40], rax
    call CreateThread

  ; ------------------------------
    add rsp, 56
    ret
create_thread endp

thread1 proc
    sub rsp, 40
  ; ------------------------------

    mov eax, 1
    lock xadd dword ptr [@lock], eax

    mov rcx, offset format2
    mov edx, eax
    mov r8d, dword ptr [@lock]
    call printf

  ; ------------------------------
    add rsp, 40
    xor eax, eax
    ret
thread1 endp

thread2 proc
    sub rsp, 40
  ; ------------------------------

    mov rcx, offset format4
    call printf

    mov ecx, 1000
    call Sleep

    mov [@lock], 0

  ; ------------------------------
    add rsp, 40
    xor eax, eax
    ret
thread2 endp

end