;	jcxz 《汇编语言 P184》
;	在内存 FFFF:0000 中查找第一个值为 0 的字节，找到后，将他的偏移地址存储在 dx 中.
;

assume cs: code

code segment

start:  mov ax, 0FFFFh ; 常量不能以字母开头,补0
		mov ds, ax
		mov bx, 0
	
;S:	mov al, ds:[bx]	; 查找字节,将 FFFF:bx 的字节赋值给 cx
;	mov ch, 0
;	mov cl, al		; 初始值 cx = 00XXh
S:	mov ch, 0
	mov cl, ds:[bx]	; 查找字节,将 FFFF:bx 的字节赋值给 cl
	jcxz OK			;如果 cx=0，则转跳到标号 OK 处
	inc bx
	
	JMP short S
OK:	mov dx, bx
	
	mov ax,4c00h
	int 21h
code ends

end start