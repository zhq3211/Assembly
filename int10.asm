
assume cs:code

code segment
	;Your program
	mov ah, 9
	mov al, 'a'
	mov bl, 7
	mov bh, 0
	mov cx, 3
	int 10h
	
	
;	mov ah, 2
;	mov bh, 0
;	mov dh, 5
;	mov dl, 12
;	int 10h
	
	mov ax, 4c00h
	int 21h

code ends
end


