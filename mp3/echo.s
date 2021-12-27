#Nick Williams
#11/15/2021 

#Registar and bit definitions from serial.h
UART_LSR = 5 #Line Status Register 
UART_LSR_THRE = 0x20 #Transmit-hold-register empty
UART_LSR_DR = 0x01 #Receiver data ready 
MS = 0x2fe #Modem Status
MC = 0x2fc #Modem Control
LS = 0x2fd #Line Status
DA = 0x2f8 #Data Addr
SC = 0xb0 #Signal Check

.text
.globl echo

echo:
    pushl %ebp
    movl %esp, %ebp
    subl $8, %esp
    movb 12(%ebp), %bl
    movl 8(%ebp), %edx
    xorl %ecx, %ecx
    movw $MC, %dx     
    inb (%dx), %al      
    orb $0x03, %al      
    outb %al, (%dx)      
    movw $MS, %dx     
loopa:
    inb (%dx), %al      
    andb $SC, %al      
    xorb $SC, %al      
    jnz loopa           
loopb:
    movw $LS, %dx     
    inb (%dx), %al      
    andb $UART_LSR_DR, %al      
    jz loopb           
    movw $DA, %dx     
    inb (%dx), %al      
    movb %al, %cl        
    cmpb %cl, %bl
    je endline
    movw $LS, %dx     
xmit:
    inb (%dx), %al      
    andb $UART_LSR_THRE, %al      
    jz      loopb           
    movb    %cl, %al        
    movw    $DA, %dx     
    outb    %al, (%dx)      
    jmp     loopb           
endline:
    mov %ebp, %esp
    popl %ebp
    ret
	.end