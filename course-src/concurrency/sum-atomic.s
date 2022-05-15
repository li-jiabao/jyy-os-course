	.file	"sum-atomic.c"
	.text
	.comm	tpool, 1536, 5
	.globl	tptr
	.data
	.align 8
tptr:
	.quad	tpool
	.text
	.globl	wrapper
	.def	wrapper;	.scl	2;	.type	32;	.endef
	.seh_proc	wrapper
wrapper:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movq	16(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	16(%rax), %rax
	movq	-8(%rbp), %rdx
	movl	(%rdx), %edx
	movl	%edx, %ecx
	call	*%rax
	movl	$0, %eax
	addq	$48, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC0:
	.ascii ".\\thread.h\0"
.LC1:
	.ascii "tptr - tpool < NTHREAD\0"
	.text
	.globl	create
	.def	create;	.scl	2;	.type	32;	.endef
	.seh_proc	create
create:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movq	tptr(%rip), %rdx
	leaq	tpool(%rip), %rax
	subq	%rax, %rdx
	movq	%rdx, %rax
	cmpq	$1512, %rax
	jle	.L6
	movl	$27, %r8d
	leaq	.LC0(%rip), %rdx
	leaq	.LC1(%rip), %rcx
	call	_assert
.L6:
	movq	tptr(%rip), %rax
	movq	tptr(%rip), %rcx
	leaq	tpool(%rip), %rdx
	subq	%rdx, %rcx
	movq	%rcx, %rdx
	movq	%rdx, %rcx
	sarq	$3, %rcx
	movabsq	$-6148914691236517205, %rdx
	imulq	%rcx, %rdx
	addl	$1, %edx
	movl	%edx, %ecx
	movq	16(%rbp), %rdx
	movq	$0, (%rax)
	movq	$0, 8(%rax)
	movq	$0, 16(%rax)
	movl	%ecx, (%rax)
	movl	$1, 4(%rax)
	movq	%rdx, 16(%rax)
	movq	tptr(%rip), %rdx
	movq	tptr(%rip), %rax
	addq	$8, %rax
	movq	%rdx, %r9
	leaq	wrapper(%rip), %r8
	movl	$0, %edx
	movq	%rax, %rcx
	call	pthread_create
	movq	tptr(%rip), %rax
	addq	$24, %rax
	movq	%rax, tptr(%rip)
	nop
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	join
	.def	join;	.scl	2;	.type	32;	.endef
	.seh_proc	join
join:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movl	$0, -4(%rbp)
	jmp	.L8
.L10:
	movl	-4(%rbp), %eax
	movslq	%eax, %rdx
	movq	%rdx, %rax
	addq	%rax, %rax
	addq	%rdx, %rax
	salq	$3, %rax
	leaq	tpool(%rip), %rdx
	addq	%rdx, %rax
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	movl	4(%rax), %eax
	cmpl	$1, %eax
	jne	.L9
	movq	-16(%rbp), %rax
	movq	8(%rax), %rax
	movl	$0, %edx
	movq	%rax, %rcx
	call	pthread_join
	movq	-16(%rbp), %rax
	movl	$2, 4(%rax)
.L9:
	addl	$1, -4(%rbp)
.L8:
	cmpl	$63, -4(%rbp)
	jle	.L10
	nop
	addq	$48, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	cleanup
	.def	cleanup;	.scl	2;	.type	32;	.endef
	.seh_proc	cleanup
cleanup:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	call	join
	nop
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section	.dtors,"w"
	.align 8
	.quad	cleanup
	.globl	sum
	.bss
	.align 4
sum:
	.space 4
	.text
	.globl	xchg
	.def	xchg;	.scl	2;	.type	32;	.endef
	.seh_proc	xchg
xchg:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$16, %rsp
	.seh_stackalloc	16
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movl	%edx, 24(%rbp)
	movq	16(%rbp), %rdx
	movl	24(%rbp), %eax
	movq	16(%rbp), %rcx
/APP
 # 10 ".\sum-atomic.c" 1
	lock xchg (%rdx),%eax
 # 0 "" 2
/NO_APP
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	addq	$16, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	Tsum
	.def	Tsum;	.scl	2;	.type	32;	.endef
	.seh_proc	Tsum
Tsum:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$16, %rsp
	.seh_stackalloc	16
	.seh_endprologue
	movl	$0, -4(%rbp)
	jmp	.L15
.L16:
/APP
 # 17 ".\sum-atomic.c" 1
	lock addq $1, sum(%rip)
 # 0 "" 2
/NO_APP
	addl	$1, -4(%rbp)
.L15:
	cmpl	$99999999, -4(%rbp)
	jle	.L16
	nop
	addq	$16, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC2:
	.ascii "sum = %ld\12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$32, %rsp
	.seh_stackalloc	32
	.seh_endprologue
	call	__main
	leaq	Tsum(%rip), %rcx
	call	create
	leaq	Tsum(%rip), %rcx
	call	create
	call	join
	movl	sum(%rip), %eax
	movl	%eax, %edx
	leaq	.LC2(%rip), %rcx
	call	printf
	movl	$0, %eax
	addq	$32, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-win32-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	_assert;	.scl	2;	.type	32;	.endef
	.def	pthread_create;	.scl	2;	.type	32;	.endef
	.def	pthread_join;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
