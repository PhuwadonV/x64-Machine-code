includelib msvcrt.lib

CreateThread proto

.code
create_thread proc export
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

end