includelib msvcrt.lib

.code
main proc
    sub rsp, 40
  ; ------------------------------

    int 3

  ; ------------------------------
    add rsp, 40
    ret
main endp

end