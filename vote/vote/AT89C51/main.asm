MOV R0,#'0'
MOV R1,#'9'
FIND:
jnb p1.0,start
sjmp find

start:
acall startlcd
mov dptr,#data1
ACALL strt
ACALL DATAWRT
find1:
jnb p1.1,start2
jnb p1.2,start3
sjmp find1
sjmp find

start2:
acall startlcd
mov dptr,#data2
acall strt
inc r0
acall value
MOV A,R0
empty:
ACALL DATAWRT
DEC R1
ACALL VALUE2
Mov A,R1
ACALL DATAWRT
sjmp find1

start3:
acall startlcd
mov dptr,#data3
acall strt
DEC r0
acall value
MOV A,R0
ACALL DATAWRT
INC R1
ACALL VALUE2
Mov A,R1
ACALL DATAWRT
sjmp find1

strt:
CLR A  
MOVC A,@A+DPTR
JZ aga
ACALL DATAWRT
inc dptr
sjmp strt
aga: RET

startlcd: 
MOV A,#80H 		
ACALL COMNWRT
MOV A,#38H 		
ACALL COMNWRT 
MOV A,#0EH 		
ACALL COMNWRT
MOV A,#01H		
ACALL COMNWRT 
MOV A,#06H 		
ACALL COMNWRT 
MOV A,#14H 		
ACALL COMNWRT
RET

value: 
MOV A,#0C0H
ACALL COMNWRT 
RET
VALUE2:
MOV A,#0C9H 		
ACALL COMNWRT 
RET
COMNWRT: 
MOV P3,A 
CLR P2.0 
CLR P2.1 
SETB P2.2 
ACALL DELAY 
CLR P2.2 
ACALL DELAY 
RET

DATAWRT:
MOV P3,A
SETB P2.0	
CLR P2.1		
SETB P2.2 
ACALL DELAY
CLR P2.2 
ACALL DELAY 
RET

DELAY: MOV R5,#50
HERE2: MOV R6,#200
HERE:DJNZ R6,HERE 
DJNZ R5,HERE2
RET

org 200h
data1: DB 'CAR PARKING SYSTEM',0
data2: DB 'CARS ENTER SLOTS',0
data3: DB 'CARS LEFT SLOTS',0

end

