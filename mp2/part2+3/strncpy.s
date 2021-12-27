#strcpy.s
#Nick Williams
#11/3/2021

	.text
	.global mystrncpy
mystrncpy:
	pushl %ebp 			#creating a stack fram
	movl %esp, %ebp 	#set esp to ebp register
	movl 8(%ebp), %ecx  #setting variable "s"
	movl 12(%ebp), %edx #setting variable "ct"
    movl 16(%ebp), %edi #setting variable "n"
str:    
	movb (%edx), %al
	movb %al, (%ecx)
	incl %ecx
	incl %edx
	decl %edi
	cmpb $0, %al
	jz endline
	cmpl $0, %edi
	jnz str
endline:
	movl 8(%ebp), %eax 
	mov %ebp, %esp
    popl %ebp
    ret
	.end