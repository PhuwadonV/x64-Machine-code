includelib msvcrt.lib
includelib legacy_stdio_definitions.lib
printf proto
GetCurrentThread proto
SetThreadAffinityMask proto
extern create_thread: proc

@l1d_size = 32768

const segment align(64) 'CONST'
src db (@l1d_size + 64) dup(?)
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
    push rbx
    push rsi
    push rdi
    sub rsp, 32

    call GetCurrentThread

    mov rcx, rax
    mov rdx, 1
    call SetThreadAffinityMask
  ; ------------------------------

    clflush [src]
    mfence
    lfence
  ; ....................
    prefetcht0 [src]
  ; ....................
    xor eax, eax
    cpuid

    rdtscp
    lfence
    mov r8d, eax
    mov r9d, edx

    mov eax, dword ptr [src]

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
  ; ....................
    prefetcht1 [src]
  ; ....................
    xor eax, eax
    cpuid

    rdtscp
    lfence
    mov r8d, eax
    mov r9d, edx

    mov eax, dword ptr [src]

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
  ; ....................
    prefetcht2 [src]
  ; ....................
    xor eax, eax
    cpuid

    rdtscp
    lfence
    mov r8d, eax
    mov r9d, edx

    mov eax, dword ptr [src]

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

    mov esi, 10000
    xor edi, edi

    align 16
start:
    clflush [src]
    mfence
    lfence

    mov r8, offset src
    xor r9, r9

    align 16
@@:
  ; ....................
    prefetchnta [r8 + r9]
  ; prefetcht0 [r8 + r9]
  ; ....................
    xor eax, eax
    cpuid
    mov edx, [r8 + r9]
    add r9d, 64
    cmp r9d, @l1d_size + 64
    jne @b

    rdtscp
    lfence
    mov r8d, eax
    mov r9d, edx

    mov eax, dword ptr [src]

    rdtscp
    shl r9, 20h
    shl rdx, 20h
    or r8, r9
    or rax, rdx
    sub rax, r8

    add rdi, rax
    sub esi, 1
    jnz start

    mov rax, rdi
    mov rcx, 10000
    cqo
    div rcx

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
    lfence
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
    add rsp, 32
    pop rdi
    pop rsi
    pop rbx
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

  ; ....................
  ; prefetchw [dst]
    prefetcht0 [dst]
  ; ....................
    xor eax, eax
    cpuid

    mov [step], 3

  ; ------------------------------
    add rsp, 32 + 8
    xor eax, eax
    ret
thread_invilidate endp

end