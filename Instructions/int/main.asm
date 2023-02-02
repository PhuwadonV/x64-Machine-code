includelib msvcrt.lib

.code
main proc
    sub rsp, 40
  ; ------------------------------

    int 3

  ; ------------------------------
    add rsp, 40
    xor eax, eax
    ret
main endp

end