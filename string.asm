data segment
str1 db 20 dup("$")
msg1 db 13,10,"Enter a string $"
msg2 db 13,10,"Entered string is $ "
data ends
code segment
assume cs:code,ds:data
start:
      mov ax,data
      mov ds,ax

      lea dx,msg1
      mov ah,09h
      int 21h
      call input
      
      lea dx,msg2
      mov ah,09h
      int 21h
      call output

      mov ah,4Ch
      int 21h


input proc 
     lea si,str1
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
     lea dx,str1
     mov ah,09h
     int 21h 
     ret
output endp

code ends
end start
     