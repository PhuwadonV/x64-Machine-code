includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto
WaitForSingleObject proto
extern create_thread: proc

.const
format1 db "Main   : %d", 0Ah, 0
format2 db "Thread : %d", 0Ah, 0

.code
main proc
    push rbx
    sub rsp, 32
  ; ------------------------------

    mov rcx, offset thread
    mov rdx, 654321
    call create_thread
    mov rbx, rax

    mov rcx, offset format1
    mov rdx, 123456
    call printf

    mov rcx, rbx
    mov rdx, 0FFFFFFFFh
    call WaitForSingleObject

  ; ------------------------------
    add rsp, 32 
    pop rbx
    xor eax, eax
    ret
main endp

thread proc
    push rbx
    sub rsp, 32
  ; ------------------------------
    
    mov rdx, rcx

    mov rcx, offset format2
    call printf

  ; ------------------------------
    add rsp, 32
    pop rbx
    xor eax, eax
    ret
thread endp

end