#count.s
#Nick Williams
#October 19, 2021

 .text
 .globl count
count:
 	pushl %ebp #creates a stack frame  
      movl  %esp, %ebp #save %esp in %ebp
      subl $8, %esp	#automatic variables
      movl 12(%ebp), %edx  
      movl 8(%ebp), %ecx 
 	movl $0, %eax          
loop: 
      movb (%ecx), %dl
      cmpb $0, %dl     
      jz end             
      cmpb 12(%ebp), %dl  
      jz sum                                    
sum:                         
      addl $1, %eax 
      addl $1, %ecx          
      jmp loop
end: 
      movl %ebp, %esp #restore %esp from %ebp
      popl %ebp #restores %ebp
      ret
      .end 