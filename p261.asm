;��̣�����Ļ��5��12����ʾ�ַ�����welcome to masm!����

assume cs:code
data segment 
 db 'Welcome to masm!','$'
data ends

code segment
start:	mov ah,2 	;�ù��
	mov bh,0	;��0ҳ
	mov dh,5	;dh�з��к�
	mov dl,12	;dl�з��к�
	int 10h
	
	mov ax,data
	mov ds,ax
	mov dx,0	;ds:dxָ���ַ������׵�ַdata:0
	mov ah,9
	int 21h

	mov ax,4c00h
	int 21h 

code ends
end start
