data segment
msg1 db 13,10,"Enter 1st number : $"
msg2 db 13,10,"Enter 2nd number : $"
msg3 db 13,10,"Result is : $"
num1 db ?
num2 db ?
result db ?
data ends
code segment
assume cs:code,ds:data
start:
      mov ax,data
      mov ds,ax
      mov cl,04h

      mov ah,09h
      lea dx,msg1
      int 21h
      call input1

      mov ah,09h
      lea dx,msg2
      int 21h
      call input2

      mov al,num1
      add al,num2
      mov result,al

      mov ah,09h
      lea dx,msg3
      int 21h
      call output

      mov ah,4ch
      int 21h

      


input1 proc
      mov ah,01h
      int 21h
      mov cl,04h

      sub al,30h
      cmp al,09h
      jle skip1
      sub al,07h
      jmp skip1
skip1: rol al,cl
      mov num1,al
      mov ah,01h
      int 21h
      sub al,30h
      cmp al,09h
      jle skip2
      sub al,07h
      jmp skip2
skip2:add al,num1
      mov num1,al
ret
input1 endp

input2 proc
      mov ah,01h
      int 21h
      mov cl,04h

      sub al,30h
      cmp al,09h
      jle skip3
      sub al,07h
      jmp skip3
skip3: rol al,cl
      mov num2,al
      mov ah,01h
      int 21h
      sub al,30h
      cmp al,09h
      jle skip4
      sub al,07h
      jmp skip4
skip4:add al,num2
      mov num2,al

ret
input2 endp

output proc
    mov al, result
    and al, 0f0h
    rol al, cl
    add al, 30h
    cmp al, 39h
    jle skip5
    add al, 07h
    jmp skip5

skip5:
    mov dl, al
    mov ah, 02h
    int 21h

    mov al, result
    and al, 0fh
    add al, 30h
    cmp al, 39h
    jle skip6
    add al, 07h
    jmp skip6

skip6:
    mov dl, al
    mov ah, 02h
    int 21h
    ret
output endp
  
      



     
code ends
end start