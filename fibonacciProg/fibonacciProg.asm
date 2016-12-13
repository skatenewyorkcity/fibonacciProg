TITLE MASM Fibonacci Project

INCLUDE Irvine32.inc

.data

  spaceVar		BYTE "  ", 0
  programTitle	BYTE "Fibonacci Numbers", 0dh, 0ah, 0
  userName		BYTE "What is your name? ", 0
  greetVar		BYTE "Greetings! ", 0
  enterDigit	BYTE "How many Fibonacci Numbers should be output?", 0dh,0ah, 0
  rangeVar		BYTE "Ensure integer chosen is between [1-46]", 0dh, 0ah, 0
  errorVar		BYTE "Error! integer must be between [1-46]", 0dh, 0ah, 0
  goodByeVar	BYTE "Au Revoir! ", 0
  buffer		BYTE 50 dup(0)
  byteCount		DWORD ?

.code
main PROC

;title
  mov edx, OFFSET programTitle
  call WriteString

;get username and greet
  mov edx, OFFSET userName
  call WriteString
  mov edx, OFFSET buffer
  mov ecx, SIZEOF buffer-1
  call ReadString
  mov edx, OFFSET greetVar
  call WriteString
  mov edx, OFFSET buffer
  call WriteString
  call Crlf

;get integer from user
inputBlock:
  mov edx, OFFSET rangeVar
  call WriteString
  mov edx, OFFSET enterDigit
  call WriteString
  call ReadDec

  ;check ReadDec between [1-46], out of range jumpt to Error block
  cmp eax, 0
  jle errorBlock
  cmp eax, 47
  jge errorBlock
  jmp mainBlock

errorBlock:
  mov edx, OFFSET errorVar
  call WriteString
  jmp inputBlock

mainBlock:
  mov ecx, eax
  mov esi, 0
  mov edi, 1

nextInt:
  mov eax, 0
  add eax, esi
  add eax, edi
  call WriteDec
  mov edx, OFFSET spaceVar
  call WriteString
  mov esi, edi
  mov edi, eax
  loop nextInt

  call Crlf
  mov edx, OFFSET goodByeVar
  call WriteString
  mov edx, OFFSET buffer
  call WriteString
  call Crlf

  call dumpRegs

  exit
   
main ENDP
END main

