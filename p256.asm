;��̣���7ch�ж��������loopָ��Ĺ��ܡ�

;�����ܣ�����Ļ�м���ʾ 80 �� '!'��
assume cs:code

code segment
start:	mov ax,0b800h
	mov es,ax
	mov di,160*12
	mov bx,offset s - offset se;���ôӱ��se�����s��ת��λ��
	mov cx,80
s:	mov byte ptr es:[di],'!'
	add di,2

	int 7ch;���(cx) != 0,ת�Ƶ���� s ��

se:	nop

	mov ax,4c00h
	int 21h
code ends
end start
