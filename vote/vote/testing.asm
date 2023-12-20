org 00h
MOV R0,#'0'
MOV R2,#'0'
MOV R1,#'0'
MOV R3,#'0'
FIND:
jnb p1.0,start
sjmp find

start:
lcall startlcd
mov dptr,#data1
lCALL strt
lCALL DATAWRT
find1:
jnb p1.1,start2
jnb p1.2,start3
jnb p1.3,yup1
sjmp find1
;sjmp find

start2:
lcall startlcd
mov dptr,#data2
lcall strt
cjne r0,#'9',f
inc r2
mov A,r2
mov r0,#'0'
mov A,r0
jmp mp
f:
mov A,r2
inc r0
MOV A,R0
empty:
mp:cjne r1,#'9',m
inc R3
Mov A,R3
mov r1,#'0'
Mov A,R1
sjmp find1
m:
Mov A,R3
Mov A,R1
sjmp find1

yup1: ljmp start4
yup2:ljmp start5
start3:
lcall startlcd
mov dptr,#data8
lcall strt
cjne r2,#'9',t
inc r2
mov A,r2

mov r0,#'0'
Mov A,R3
jmp vp
t:
mov A,r2
MOV A,R0
vp:cjne r1,#'9',w
inc R3
Mov A,R3
mov r1,#'0'
Mov A,R1
ljmp find1
w:
Mov A,R3
INC R1
Mov A,R1
ljmp find1
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
MOV A,#0C2H
ACALL COMNWRT
RET
VALUE2:
MOV A,#0CBH
LCALL COMNWRT
RET
VALUE3:
MOV A,#0C1H
LCALL COMNWRT
RET
VALUE4:
MOV A,#0CAH
LCALL COMNWRT
RET
COMNWRT:
MOV P3,A
CLR P2.0
CLR P2.1
SETB P2.2 
LCALL DELAY 
CLR P2.2 
LCALL DELAY 
RET

DATAWRT:
MOV P3,A
SETB P2.0	
CLR P2.1		
SETB P2.2 
LCALL DELAY
CLR P2.2 
LCALL DELAY 
RET

DELAY: MOV R5,#50
HERE2: MOV R6,#200
HERE:DJNZ R6,HERE 
DJNZ R5,HERE2
RET
org 200h
data1: DB 'Voting Machine',0
data2: DB 'voted for A',0
data3: DB 'Winner->Team A',0
data4: DB 'Winner->Team B',0
data5: DB 'scores Tie',0 
data6: DB 'Total Votes',0
data7: DB 'Team A  Team B',0
data8: DB 'Voted For B',0
start5:
lcall startlcd
mov dptr,#data7
lcall strt
lcall value3
mov a,r2
lcall datawrt
lcall value
mov a,r0
lcall datawrt
lcall value4
mov a,r3
lcall datawrt
lcall value2
mov a,r1
lcall datawrt
lcall delay
lcall delay
lcall startlcd
mov dptr,#data6
lcall strt
loop5:
goo4:
cjne r1,#'0',goo
goo5:cjne r3,#'0',goo1
sjmp goo2
goo:
cjne r0,#'9',goo3
mov R0,#'0'
dec R1
inc R2
sjmp goo4
goo3:
inc r0
dec r1
sjmp goo4
goo1:
inc r2
dec r3
sjmp goo5

 goo2:lcall value
 mov a,r0
 lcall datawrt
 lcall value3
 mov a,r2
  lcall datawrt
  acall delay 
 stop:jmp stop
start4: 
 mov a,r2
 mov b,r3
 cjne a,b,we
 mov a,r0
 mov b,r1
 cjne a,b,he
 jmp tie
 he: subb a,b
 jc winb
 jmp wina
 we: subb a,b
 jc winb
 jmp wina

wina:lcall startlcd
mov dptr,#data3
lCALL strt
lCALL DATAWRT
lcall delay
jmp yup2
winb:lcall startlcd
mov dptr,#data4
lCALL strt
lCALL DATAWRT
lcall delay
jmp yup2
tie:lcall startlcd
mov dptr,#data5
lCALL strt
lCALL DATAWRT
lcall delay
jmp yup2
end