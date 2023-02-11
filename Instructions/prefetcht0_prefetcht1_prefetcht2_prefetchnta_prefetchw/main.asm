includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto
GetCurrentThread proto
SetThreadAffinityMask proto
extern create_thread: proc

@l1_size = 262144

const segment align(64) 'CONST'
src dd (@l1_size / 4) dup(?)
const ends

.const
separator db 30 dup("-"), 0Ah, 0
format db "%lld", 0Ah, 0

data segment align(64) 'DATA'
dst dd (16 * 64) dup(0h)
step dd 0
data ends

.code
main proc
    sub rsp, 32 + 8

    call GetCurrentThread

    mov rcx, rax
    mov rdx, 1
    call SetThreadAffinityMask
  ; ------------------------------

    clflush [src]

    lfence

    prefetcht0 [src]

    mfence

    rdtscp
    mov r8d, eax
    mov r9d, edx

    mov eax, [src]

    rdtscp
    shl r9, 20h
    shl rdx, 20h
    or r8, r9
    or rax, rdx
    sub rax, r8

    mov rcx, offset format
    mov rdx, rax
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    clflush [src]

    lfence

    prefetcht1 [src]

    mfence

    rdtscp
    mov r8d, eax
    mov r9d, edx

    mov eax, [src]

    rdtscp
    shl r9, 20h
    shl rdx, 20h
    or r8, r9
    or rax, rdx
    sub rax, r8

    mov rcx, offset format
    mov rdx, rax
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    clflush [src]

    lfence

    prefetcht2 [src]

    mfence

    rdtscp
    mov r8d, eax
    mov r9d, edx

    mov eax, [src]

    rdtscp
    shl r9, 20h
    shl rdx, 20h
    or r8, r9
    or rax, rdx
    sub rax, r8

    mov rcx, offset format
    mov rdx, rax
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    clflush [src]

    lfence

    prefetcht2 [src]

    mfence

    rdtscp
    mov r8d, eax
    mov r9d, edx

    mov eax, [src]

    rdtscp
    shl r9, 20h
    shl rdx, 20h
    or r8, r9
    or rax, rdx
    sub rax, r8

    mov rcx, offset format
    mov rdx, rax
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    clflush [src]

    lfence

    mov rax, offset src + 512
    xor ecx, ecx

    align 16
@@:
    prefetchnta [rax + rcx]
  ; prefetcht0 [rax + rcx]
    add ecx, 64
    cmp ecx, @l1_size
    jne @b

    mfence

    rdtscp
    mov r8d, eax
    mov r9d, edx

    mov eax, [src]

    rdtscp
    shl r9, 20h
    shl rdx, 20h
    or r8, r9
    or rax, rdx
    sub rax, r8

    mov rcx, offset format
    mov rdx, rax
    call printf

  ; ------------------------------
    mov rcx, offset separator
    call printf
  ; ------------------------------

    mov rcx, thread_invilidate
    call create_thread

@@:
    cmp [step], 1
    jne @b

    mov eax, [dst]
    mov [step], 2

@@:
    cmp [step], 3
    jne @b

    rdtscp
    mov r8d, eax
    mov r9d, edx

    mov eax, [dst]

    rdtscp
    shl r9, 20h
    shl rdx, 20h
    or r8, r9
    or rax, rdx
    sub rax, r8

    mov rcx, offset format
    mov rdx, rax
    call printf
  
  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
main endp

thread_invilidate proc
    sub rsp, 32 + 8

    call GetCurrentThread

    mov rcx, rax
    mov rdx, 4
    call SetThreadAffinityMask
  ; ------------------------------

    mov [step], 1

@@:
    cmp [step], 2
    jne @b

    prefetchw [dst]
  ; prefetcht0 [dst]
    mov [step], 3

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
thread_invilidate endp

end