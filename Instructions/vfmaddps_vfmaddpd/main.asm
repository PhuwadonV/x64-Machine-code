includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto

.const
separator db 30 dup("-"), 0Ah, 0
format1 db 4 dup("%f "), 0Ah, 0
format2 db 2 dup("%f "), 0Ah, 0

align 16
src1 dd 2.0f, 2.0f, 2.0f, 2.0f
src2 dd 3.0f, 3.0f, 3.0f, 3.0f
src3 dd 4.0f, 4.0f, 4.0f, 4.0f
src4 dq 2.0, 2.0
src5 dq 3.0, 3.0
src6 dq 4.0, 4.0

.code
main proc
    sub rsp, 32 + 8
  ; ------------------------------

    vmovaps xmm0, [src1]
    vmovaps xmm1, [src2]
    vmovaps xmm2, [src3]
    vfmadd132ps xmm0, xmm1, xmm2
    vcvtps2pd ymm0, xmm0
    vmovupd [rsp + 8], ymm0

    mov rcx, offset format1
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    mov r9, [rsp + 24]
    vzeroupper
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    vmovaps xmm0, [src1]
    vmovaps xmm1, [src2]
    vmovaps xmm2, [src3]
    vfmadd213ps xmm0, xmm1, xmm2
    vcvtps2pd ymm0, xmm0
    vmovupd [rsp + 8], ymm0

    mov rcx, offset format1
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    mov r9, [rsp + 24]
    vzeroupper
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    vmovaps xmm0, [src1]
    vmovaps xmm1, [src2]
    vmovaps xmm2, [src3]
    vfmadd231ps xmm0, xmm1, xmm2
    vcvtps2pd ymm0, xmm0
    vmovupd [rsp + 8], ymm0

    mov rcx, offset format1
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    mov r9, [rsp + 24]
    vzeroupper
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    vmovapd xmm0, [src4]
    vmovapd xmm1, [src5]
    vmovapd xmm2, [src6]
    vfmadd132pd xmm0, xmm1, xmm2
    movupd [rsp + 8], xmm0

    mov rcx, offset format2
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    vmovapd xmm0, [src4]
    vmovapd xmm1, [src5]
    vmovapd xmm2, [src6]
    vfmadd213pd xmm0, xmm1, xmm2
    movupd [rsp + 8], xmm0

    mov rcx, offset format2
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    vmovapd xmm0, [src4]
    vmovapd xmm1, [src5]
    vmovapd xmm2, [src6]
    vfmadd231pd xmm0, xmm1, xmm2
    movupd [rsp + 8], xmm0

    mov rcx, offset format2
    mov rdx, [rsp + 8]
    mov r8, [rsp + 16]
    call printf

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

end