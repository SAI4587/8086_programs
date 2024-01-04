data segment
str1 db 20 dup("$")
str2 db 20 dup("$")
msg1 db 13,10,"Enter a string $"
msg2 db 13,10,"Enter a string to concat $ "
msg3 db 13,10,"concatenated string is $ "
data ends
code segment
assume cs:code,ds:data
start:
      mov ax,data
      mov ds,ax
      
      lea dx,msg1
      mov ah,09h
      int 21h
      lea si,str1
      call input
      
      lea dx,msg2
      mov ah,09h
      int 21h
      lea si,str2
      call input

      lea dx,msg3
      mov ah,09h
      int 21h
      call concat

      mov ah,4Ch
      int 21h


input proc 
loop1: mov ah,01h
      int 21h
      cmp al,13
      je skip1
      mov [si],al
      inc si
      jmp loop1
skip1: ret
input endp

output proc
     mov ah,09h
     int 21h 
     ret
output endp

concat proc
     lea si,str1
     lea di,str2
     mov al,'$'
     mov cl,0

loop2:cmp al,[si]
      je addspace
      inc si
      jmp loop2

addspace:mov [si],cl
         inc si
         jmp skip2

skip2:
      cmp [di],al
      je endc
      mov bl,[di]
      mov [si],bl
      inc si
      inc di
      jmp skip2

endc: mov [di],al
      lea dx,str1
      call output
      ret
concat endp
      
code ends
end start
     