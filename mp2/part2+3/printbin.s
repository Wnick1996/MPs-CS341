#printbin.s
#Nick Williams
#11/03/2021

.text
.global printbin

printbin:
	pushl %ebp
	movl %esp, %ebp
	movb 8(%ebp), %al   # get the input of 2 hex letters
	movl $string, %edx
	call donibble	 	# call donibble
	movl $' ', (%edx) 	# spaces the string
	incl %edx			# increment edx pointer
	call donibble
	movl $string, %eax	# creates return value in %eax
	movl %ebp, %esp		# delete stack frame
	popl %ebp
	ret					# call back to caller
donibble:
	movl $4, %ecx		# loop four times
loopfork:
	shlb $1, %al			# shift the msb to carry flag
	jc loopa			# if the flag is not set
	movb $'0', (%edx)	# increment string with ascii 0
	jmp loopb			# else
loopa:
	movb $'1', (%edx)	# increment string with ascii 1
loopb:	
	incl %edx			# increment pointer to string
	loop loopfork
	ret
	.data
string:
	.asciz "xxxx xxxx\n"