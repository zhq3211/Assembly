;	一个奇怪的程序 《汇编语言 P187》
;
;

assume cs: code

code segment

	mov ax,4c00H
	INT 21H

Start: 	mov ax,0
	S:	NOP
		NOP
		
		mov di, offset S
		mov si, offset S2
		mov ax, cs:[si]
		mov cs:[di], ax
	
	S0:	JMP short S
		
	S1:	MOV ax, 0
		int 21H
		mov ax, 0
		
	S2:	JMP short S1
		nop

code ends

end Start


