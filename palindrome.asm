data segment
str1 db 20 dup("$")
str2 db 20 dup("$")
msg1 db 13,10,"Enter a string $"
msg3 db 13,10,"reversed string is $ "
msg4 db 13,10,"not palindrome $ "
msg5 db 13,10,"palindrome $ "
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

      lea dx,msg3
      mov ah,09h
      int 21h
      call concat
      call palindrome

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
     mov cl,0h
     mov al,'$'

loop2:cmp al,[si]
      je skipdollar
      inc si
      inc cl
      jmp loop2

skipdollar : dec si
             jmp skip2

skip2:
      cmp cl,0h
      je endc
      mov bl,[si]
      mov [di],bl
      dec si
      inc di
      dec cl
      jmp skip2

endc: mov [di],al
      lea dx,str2
      call output
      ret
concat endp

palindrome proc
      lea si,str1
      lea di,str2
      mov al,'$'

checkloop:
          mov bl,[si]
          cmp bl,[di]
          jne notpalindrome
          cmp bl,'$'
          je itspalindrome
          inc si
          inc di
          jmp checkloop
          
notpalindrome:lea dx,msg4 
              mov ah,09h
              int 21h
              ret

itspalindrome:lea dx,msg5 
              mov ah,09h
              int 21h
              ret
palindrome endp

      
code ends
end start
     