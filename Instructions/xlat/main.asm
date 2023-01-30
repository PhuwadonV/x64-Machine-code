includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

@size = 7

.const
format db @size dup('%c'), 0
lookup_table db " ABCDEFGHIJKLMNOPQRSTUVWXYX", 0

.data
src db @size dup(?)

.code
main proc
    push rbx
    push rsi
    push rdi
    sub rsp, 64
  ; ------------------------------

    mov byte ptr [src + 0], 3  ; C
    mov byte ptr [src + 1], 1  ; A
    mov byte ptr [src + 2], 20 ; T
    mov byte ptr [src + 3], 0  ;
    mov byte ptr [src + 4], 4  ; D
    mov byte ptr [src + 5], 15 ; O
    mov byte ptr [src + 6], 7  ; G

    mov rbx, offset lookup_table
    mov rsi, offset src
    lea rdi, [rsp + 8]
    xor ecx, ecx

    align 16
@@:
    xor eax, eax
    mov al, [rsi + rcx]
    xlat
    mov [rdi + rcx * 8], al
    inc ecx
    cmp ecx, @size
    jne @b

    mov rcx, offset format
    movzx edx, byte ptr [rsp + 8]
    movzx r8d, byte ptr [rsp + 16]
    movzx r9d, byte ptr [rsp + 24]
    call printf

  ; ------------------------------
    add rsp, 64
    pop rdi
    pop rsi
    pop rbx
    xor eax, eax
    ret
main endp

end