;	★ RGB 	《汇编语言》P188; P206
;	优化：使用 Call & Ret 调用子程序 【通用】
; 	参考：CallRet1.asm
;////////////////////////////////////////////////////////////////////////////////
;	功能:
;		在屏幕中间分别显示绿色、 绿底红字、 闪烁白底蓝色 的字符串 'Welcome to zhq3211.'
;		即：(0行开始)分别在屏幕的第10, 12, 14行的第29列开始显示字符串.
;///////////////////////////////////////////////////////////////////////////////

assume cs:code

data segment
	db 'Welcome to zhq3211.' 
data ends

code segment
start:	
		;//绿色-00000010b 字符串 
		mov bh, 0	;bx 的低位保存属性
		mov bl, 02h	;字符串属性
		mov cx, 19 	;字符串长度(用于子程序循环)
		mov dh, 10	;屏幕行号 (0开始-N)
		mov dl, 29	;屏幕列号 (0开始-M)
		CALL VideoBuffer
		CALL ShowStr
		
		;//绿底红字-00100100b 字符串
		mov bh, 0	;bx 的低位保存属性
		mov bl, 24h	;字符串属性
		mov cx, 19 	;字符串长度(用于子程序循环)
		mov dh, 12	;屏幕行号 (0开始-N)
		mov dl, 29	;屏幕列号 (0开始-M)
		CALL VideoBuffer
		CALL ShowStr
		
		;//闪烁白底蓝色-11110001b 字符串
		mov bh, 0	;bx 的低位保存属性
		mov bl, 71h	;字符串属性
		mov cx, 19 	;19个字符串(用于子程序循环)
		mov dh, 14	;屏幕行号 (0开始-N)
		mov dl, 29	;屏幕列号 (0开始-M)
		CALL VideoBuffer
		CALL ShowStr
	
		mov ax,4c00H
		int 21H

		
;===================================================
;(子程序前，属性-bl, 长度-cx, 行/列号-dx 数据需保留) 
;子程序1：计算显示缓冲区偏移地址
;===================================================
VideoBuffer:
	push bx		;主程序 bx 的低位用于保存字符串属性，进栈保护
	
	mov al, dh	;第N行
	mov bl, 160
	mul bl		;ax= al*bl = N*80*2
	mov di, ax
	
	mov al, dl	;第M列
	mov bl, 2
	mul bl		;ax= al*bl = M*2
	
	add di, ax 	;di=di+ax = N*80*2+M*2 偏移地址保存在 di
	
	pop bx
ret	


;==========================================================
;(子程序前，属性-bx/bl, 长度-cx, 显存缓冲区-di 数据需保留)
;子程序2：写入显示缓冲区
;==========================================================
ShowStr:	
	mov si, 0	
Print:
	mov ax, data
	mov ds, ax
	mov ax, ds:[si]	;ax= 字符串 ASCII; bl=颜色属性 
	
	mov dx, 0B800h
	mov ds, dx
	mov ds:[di], ax	;ASCII
	mov ds:[di+1], bx	;属性
	
	inc si
	add di, 2
loop Print
ret

code ends

end start
