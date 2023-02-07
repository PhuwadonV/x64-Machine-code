includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto
GetCurrentThread proto
SetThreadAffinityMask proto
WaitForSingleObject proto
extern create_thread: proc

const segment align(64) 'CONST'
src dd 16 dup(0h)
const ends

.const
separator db 30 dup("-"), 0Ah, 0
format db "%lld", 0Ah, 0

.data
step dd 0

.code
main proc
    sub rsp, 32 + 8

    call GetCurrentThread

    mov rcx, rax
    mov rdx, 1
    call SetThreadAffinityMask
  ; ------------------------------

    clflush [src]

    mfence

    prefetcht0 [src]

    mfence
    lfence

    rdtscp
    mov r8d, eax
    mov r9d, edx

    mov eax, [src]
    mfence

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
    lfence

    rdtscp
    mov r8d, eax
    mov r9d, edx

    mov eax, [src]
    mfence

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
    lfence

    rdtscp
    mov r8d, eax
    mov r9d, edx

    mov eax, [src]
    mfence

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
    lfence

    rdtscp
    mov r8d, eax
    mov r9d, edx

    mov eax, [src]
    mfence

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

    mfence
    lfence

    mov rcx, thread
    call create_thread

@@:
    cmp [step], 1
    jne @b

    mfence
    lfence

    rdtscp
    mov r8d, eax
    mov r9d, edx

    mov eax, [src]
    mfence

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

thread proc
    sub rsp, 32 + 8

    call GetCurrentThread

    mov rcx, rax
    mov rdx, 1
    call SetThreadAffinityMask
  ; ------------------------------
    
    prefetchnta [src]
    mov [step], 1

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
thread endp

end