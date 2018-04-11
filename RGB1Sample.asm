;	★ RGB 	《汇编语言》P188
;	一、DOS 屏幕
;		80x25 彩色字符模式：
;			显示器可以显示25行，每行80个字符(Byte). 每个字符可以有256种属性(闪烁，背景色，高亮，前景色等组合信息).
;			一个字符占两个存储空间(ASCII-低位+属性-高位).
;			
;	二、显示缓冲区
;		内存地址空间为 B8000h-BFFFFh 共 32KB 空间.
;
;				00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F
;	B800:0000	41 02 .. .. .. .. .. .. .. .. .. .. .. .. .. ..
;		:
;	B800:0090	.. .. .. .. .. .. .. .. .. .. .. .. .. .. .. .. 
;				>>> 41h 表示'A', 02h 表示‘A’的属性为黑底绿色.
;					B8000~B809F 对应显示器上的第一行.
;					(显示缓冲区160bytes 对应显示器第一行的80bytes)
;	B800:00A0	.. .. .. .. .. .. .. .. .. .. .. .. .. .. .. ..
;		:
;	B800:7FF0	.. .. .. .. .. .. .. .. .. .. .. .. .. .. .. ..
;
;
;	三、RGB & 光学三原色 & RGB颜色查询对照表
;		bit		7	6	5	4	3	2	1	0
;		含义	BL	R	G	B	I	R	G	B
;				--  ----------  -   ---------
;				闪烁   背景    高亮	  前景
;		R - Red   红
;		G - Green 绿
;		B - Blue  蓝
;			
;		如:
;		黑色：000b
;		白色：111b
;		黑底白字: 		00000111b = 07h (-d B800:0, 看到的默认属性 byte 确实都是 07h)
;		蓝底白字：		00010111b = 17h
;		白底闪烁蓝字：	11110001b (PS: 闪烁功能需要在全屏DOS下才有效！)
;
;		光学三原色：红+绿=黄；绿+蓝=青； 蓝+红=品红(深红); 红+绿+蓝=白
;



;////////////////////////////////////////////////////////////////////////////////
;	功能:
;		在屏幕中间分别显示绿色、绿底红字、白底蓝色的字符串 'Welcome to zhq3211.'
;	解读：
;		屏幕第1行，对应显示缓冲区的 B800:0000h~B800:009Fh
;		绿色的'Welcome to zhq3211.' -- 第11行,第30个字符开始(1-25行)，对应显示缓冲区的 B800:0AA0h+1Eh~B800:0B3Fh
;		绿底红字的'Welcome to zhq3211.' -- 第13行，对应显示缓冲区的 B800:0B40h~B800:0BDFh
;		白底蓝色的'Welcome to zhq3211.' -- 第15行，对应显示缓冲区的 B800:0BE0h~B800:0C7Fh
;///////////////////////////////////////////////////////////////////////////////
assume cs: code ;ds:data

;data segment
;	db 'Welcome to zhq3211.'
;data ends

code segment
	mov ax, 0B800H
	mov ds, ax	;显存缓冲区范围 B800:0000h~B800:7FFFh

;==============================================
;屏幕第11行中间显示绿色的'Welcome to zhq3211.'
;==============================================
	mov bx, 640h+3Ch 	;对应第11行(640h-6DFh),第30(3Ch=60)个字符
	
	;mov cx 0Ah 	;循环10次，分别输入字符 'Welcome to zhq3211.' 
	
	mov dx, 'W'			;字符ASCII码：'W'
	mov ds:[bx], dx
	mov dx, 02h			;字符属性：绿色字体
	mov ds:[bx+1], dx
	add bx,2
	
	mov dx, 'e'
	mov ds:[bx], dx
	mov dx, 02h
	mov ds:[bx+1], dx
	add bx,2
	
	mov dx, 'l'
	mov ds:[bx], dx
	mov dx, 02h
	mov ds:[bx+1], dx
	add bx,2
	
	mov dx, 'c'
	mov ds:[bx], dx
	mov dx, 02h
	mov ds:[bx+1], dx
	add bx,2
	
	mov dx, 'o'
	mov ds:[bx], dx
	mov dx, 02h
	mov ds:[bx+1], dx
	add bx,2
	
	mov dx, 'm'
	mov ds:[bx], dx
	mov dx, 02h
	mov ds:[bx+1], dx
	add bx,2
	
	mov dx, 'e'
	mov ds:[bx], dx
	mov dx, 02h
	mov ds:[bx+1], dx
	add bx,2
	
	mov dx, ' '
	mov ds:[bx], dx
	mov dx, 02h
	mov ds:[bx+1], dx
	add bx,2
	
	mov dx, 't'
	mov ds:[bx], dx
	mov dx, 02h
	mov ds:[bx+1], dx
	add bx,2
	
	mov dx, 'o'
	mov ds:[bx], dx
	mov dx, 02h
	mov ds:[bx+1], dx
	add bx,2
	
	mov dx, ' '
	mov ds:[bx], dx
	mov dx, 02h
	mov ds:[bx+1], dx
	add bx,2
	
	mov dx, 'z'
	mov ds:[bx], dx
	mov dx, 02h
	mov ds:[bx+1], dx
	add bx,2
	
	mov dx, 'h'
	mov ds:[bx], dx
	mov dx, 02h
	mov ds:[bx+1], dx
	add bx,2
	
	mov dx, 'q'
	mov ds:[bx], dx
	mov dx, 02h
	mov ds:[bx+1], dx
	add bx,2
	
	mov dx, '3'
	mov ds:[bx], dx
	mov dx, 02h
	mov ds:[bx+1], dx
	add bx,2
	
	mov dx, '2'
	mov ds:[bx], dx
	mov dx, 02h
	mov ds:[bx+1], dx
	add bx,2
	
	mov dx, '1'
	mov ds:[bx], dx
	mov dx, 02h
	mov ds:[bx+1], dx
	add bx,2
	
	mov dx, '1'
	mov ds:[bx], dx
	mov dx, 02h
	mov ds:[bx+1], dx
	add bx,2
	
	mov dx, '.'
	mov ds:[bx], dx
	mov dx, 02h
	mov ds:[bx+1], dx
	add bx,2

	mov ax,4c00h
	int 21h
code ends
end 
