;	loop 《汇编语言 P185》
;	在内存 FFFF:0000 中查找第一个值为 0 的字节，找到后，将他的偏移地址存储在 dx 中.
;

assume cs: code

code segment

start:  mov ax, 0FFFFh ; 常量不能以字母开头，补0
		mov ds, ax
		mov bx, 0

	s: 	mov ch,0
		mov cl,ds:[bx] ; 查找字节,将 FFFF:bx 的字节赋值给 cl, 即cx=bx低字节
		mov cx,
	
	mov ax,4c00h
	int 21h
code ends

end start