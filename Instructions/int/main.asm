includelib msvcrt.lib

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    int 3

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end