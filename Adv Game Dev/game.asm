INCLUDE Irvine32.inc

.data

SmileyFace = 2
ArrowCharacter = 16

SpacebarCharacter = 32

;Messages
gameoverbordermsg BYTE "GAME OVER: Hit Border",0
gameoverpointsmsg BYTE "GAME OVER: Out of Points",0
gameoverrqmsg BYTE "GAME OVER: Quit",0
currentscore BYTE "Score = ",0
currentpoints BYTE "Points = ",0
space BYTE "    ", 0
picklevelmsg BYTE "Pick your player skill level:",0

;Key codes
leftkey BYTE 01Eh ;A OR a        
rightkey BYTE 026h ;L or l
spacebar BYTE 039h ;space
escapekey BYTE 01h ;esc

upkey BYTE 011h ;W
downkey BYTE 01Fh ;S
returnkey BYTE 01Ch ; enter

;What to do
goleft BYTE 01h        
gopause BYTE 02h
goright BYTE 03h


olddoing BYTE 01h
oldkey BYTE 026h

GameOverBecause BYTE 0

;Border
rightborder BYTE 79
leftborder BYTE 0
borderchar = 219

;Score
bounces SDWORD 0
points SDWORD 50
decreaseby SDWORD 0

temp BYTE 0 
temp2 BYTE 0


delaytime BYTE 50
strL1 BYTE "Novice",0 
strL2 BYTE "Intermediate",0 
strL3 BYTE "Advanced",0 
strL4 BYTE "Expert",0 
strL5 BYTE "Insane",0

availableLevels DWORD OFFSET strL1, OFFSET strL2, OFFSET strL3, OFFSET strL4, OFFSET strL5

delayTimePerLevel BYTE   70, 50, 40, 30, 20
numberOfLevels = lengthof delayTimePerLevel
picklevel BYTE 0


.code

displayInfo PROC
;Print score messages
	mov dh, 0
	mov dl, 0
	call gotoxy
	mov edx, OFFSET currentscore
	call writestring
	mov eax, bounces
	call writeint
	call crlf
	mov edx, OFFSET currentpoints
	call writestring
	mov eax, points
	call writeint
	mov edx, OFFSET space
	call writestring
ret
displayInfo ENDP


playGame PROC

;Initialize where to start printing
mov dl, 1
mov dh, 6

;Old keys
mov bl, rightkey
mov bh, 1

;Store dl
mov temp, dl
mov al, borderchar

;Make border
mov dl, leftborder
call gotoxy
call writechar
mov dl, rightborder
call gotoxy
call writechar

;Write score messages
call displayInfo

;Take dl out
mov dl, temp
mov dh, 6

;Update border values
inc leftborder
dec rightborder

;Move labels to move character around
call generateBall

jmp MainLoop
MoveRight:
	call gotoxy
	mov al, SpacebarCharacter
	call writeChar
	inc dl
	call gotoxy
	
	call IsInDangerZone
	mov al, smileyface
	call writechar
	call ResetColors
	
	call gotoxy
	
	dec dl
	cmp dl, rightborder
	jz gameoverborder
	inc dl
	
	mov cl, oldkey
	cmp cl, rightkey
	mov cl, rightkey
	mov oldkey,cl
	jne DecreaseRightBorder
	jmp MainLoop
	
MoveLeft:
	call gotoxy
	mov al, SpacebarCharacter
	call writeChar
	dec dl
	call gotoxy
	
	call IsInDangerZone
	mov al, smileyface
	call writechar
	call ResetColors
	
	call gotoxy
	
	inc dl
	cmp dl, leftborder
	jz gameoverborder
	dec dl
	
	mov cl, oldkey
	cmp cl,leftkey
	mov cl,leftkey
	mov oldkey,cl
	jne DecreaseLeftBorder
	
	jmp MainLoop

;print reason for game over/crash
gameoverborder:
	call crlf
	mov edx, OFFSET gameoverbordermsg
	call writestring
	call crlf
	ret
gameoverpoints:
	call crlf
	mov edx, OFFSET gameoverpointsmsg
	call writestring
	call crlf
	ret
gameoverrq:
	call crlf
	mov edx, OFFSET gameoverrqmsg
	call writestring
	call crlf
	ret

;"chg" labels change old inputs before doing what they're supposed to do
chgR:
	mov bh, goleft
	mov olddoing, bh
	jmp MoveRight
	
chgL:
	mov bh, goright
	mov olddoing, bh
	jmp MoveLeft
	
chgP:
	call pauseIt

;What main loop defaults to, if no keys are pressed
zero:
	cmp bh,goleft
	je chgr
	
	cmp bh, gopause
	je MainLoop
	
	cmp bh, goright
	je chgl
	
	mov bh, olddoing
	jmp zero

DecreaseRightBorder:
	mov temp, dh
	mov temp2, dl
	mov eax, points
	movzx edx, dl
	sub eax, edx
	movzx edx, leftborder
	add eax, edx
	inc eax
	mov points, eax
	mov dh, temp
	mov dl, temp2
	
	;Write border
	dec dl
	mov leftborder, dl
	dec dl
	mov al, borderchar
	call gotoxy
	call writechar
	
	inc bounces ;Give bounce point after every border change
	
	;Write score messages
	call displayInfo
	
	cmp eax, 0
	jle gameoverpoints
	
	;Update position
	mov dl,leftborder
	mov dh, 6
	call gotoxy

	jmp MainLoop
DecreaseLeftBorder:
	mov temp, dh
	mov temp2, dl
	mov eax, points
	movzx edx, dl
	add eax, edx
	movzx edx, rightborder
	sub eax, edx
	inc eax
	mov points, eax
	mov dh, temp
	mov dl, temp2
	
	;Write border
	inc dl
	mov rightborder,dl
	inc dl
	mov al, borderchar
	call gotoxy
	call writechar
	
	inc bounces ;Give bounce point after every border change
	
	;Write score messages
	call displayInfo
	
	cmp eax, 0
	jle gameoverpoints
	
	;Update position
	mov dl,rightborder
	mov dh, 6
	call gotoxy
	
	jmp MainLoop

;Loop controlling the game with the keys input by gamer
MainLoop:
	movzx eax, delaytime
	call delay
	mov cl, dl
	mov ch, dh
	call readkey
	;jz zero
	mov dl,cl
	mov dh,ch
	mov bl, ah
    	
	jz zero
	
	cmp ah, escapekey
	je gameoverrq
	
	cmp ah, rightkey
	je chgR
	
	cmp ah, leftkey
	je chgL
	
	cmp bl, spacebar
	je chgP
	
	jmp zero

ret
playGame ENDP
                          

refreshPick PROC
	
	mov ecx, numberOfLevels
	mov bl, 0
	
	mov dl, 0
	mov dh, 2
	
	call gotoxy
	
	jmp RefreshArrow
	
	arrow_here:
		call gotoxy
		mov al, ArrowCharacter
		call writechar
		inc bl
		jmp RefreshArrow
	
	RefreshArrow:
		mov dh, 2
		mov dl, 0
		add dh, bl
		
		call gotoxy
		
		cmp bl, picklevel
		je arrow_here
		call gotoxy
		mov edx, OFFSET space
		call writestring
		inc bl
	loop RefreshArrow
	call crlf
	ret
refreshPick ENDP  

DecreaseLevel PROC
	jmp DecMain
	DecWrap:
		mov bl, numberoflevels
		dec bl
		mov picklevel, bl
		ret
	DecMain:
		mov bl, 0
		cmp bl, picklevel
		je DecWrap
		dec picklevel
	ret
DecreaseLevel ENDP  

IncreaseLevel PROC
	jmp IncMain
	IncWrap:
		mov bl, 0
		mov picklevel, bl
		ret
	IncMain:
		mov bl, numberofLevels
		dec bl
		
		cmp bl, picklevel
		je IncWrap
		inc picklevel
	ret
ret
IncreaseLevel ENDP                        

selectLevel PROC
	
call clrscr
mov dl,0
mov dh,0
call gotoxy
	
mov edx, OFFSET picklevelmsg
call writestring
call crlf
call crlf
	
mov ecx, numberOfLevels
mov esi, 0
	
printOutLevels:
	mov edx, OFFSET space
	call writestring
	
	mov edx, [availableLevels + esi]
	call writestring
	add esi, 4
	call crlf
loop printOutLevels

call refreshPick

jmp Choosing

ToDecreaseLevel:
	call DecreaseLevel
	call RefreshPick
	jmp Choosing
	
ToIncreaseLevel:
	call IncreaseLevel
	call RefreshPick
	jmp Choosing
	
ChoseLevel:
	movzx ecx, pickLevel
	inc ecx
	mov esi, OFFSET delayTimePerLevel
	GettingLevel:
		mov bl, [esi]
		mov delaytime, bl
		inc esi
	loop GettingLevel
	call clrscr
	ret
	
Choosing:
	movzx eax, delaytime
	call delay
	mov cl, dl
	mov ch, dh
	call readkey
	mov dl,cl
	mov dh,ch
	mov bl, ah
	jz Choosing
	
	mov bl, ah
	
	cmp bl, upkey
	je ToDecreaseLevel
	
	cmp bl, downkey
	je ToIncreaseLevel
	
	cmp bl, returnkey
	je ChoseLevel
	
	jmp Choosing
	
call waitmsg
call clrscr
ret
selectLevel ENDP


generateBall PROC
jmp mainGenerate
makeItMoveLeft:
	mov dl, 39
	mov al, goleft
	mov oldDoing, al
	mov al, leftkey
	mov OldKey,al
	mov bl, olddoing
	mov bh, 3
	ret
makeItMoveRight:
	mov dl, 39
	mov al, goRight
	mov oldDoing, al
	mov al,rightkey
	mov OldKey,al
	mov bl, olddoing
	mov bh, 1
	ret
mainGenerate:
	mov eax, 2
	call Randomize
	call Randomrange
	
	cmp eax, 1
	je makeItMoveLeft
	
	jmp makeItMoveRight
	
ret
generateBall ENDP


;procedure for game/ball in danger
isInDangerZone PROC
jmp mainIsInDangerZone

inDangerZone:
	mov eax, red+(black*16)
	call settextcolor
	mov bl,temp
	ret
inWarningZone:
	mov eax, yellow+(black*16)
	call settextcolor
	mov bl,temp
	ret
dangerMovingRight:
	mov al, rightborder
	sub al, dl
	cmp al, 8
	jbe inDangerZone
	mov al, rightborder
	sub al, dl
	cmp al, 16
	jbe inWarningZone
	ret
dangerMovingLeft:
	mov al, dl
	sub al, leftborder
	cmp al, 8
	jbe inDangerZone
	mov al, dl
	sub al, leftborder
	cmp al, 16
	jbe inWarningZone
	ret

mainIsInDangerZone:
	mov temp, bl
	mov bl, 1h
	cmp bl, olddoing
	je dangerMovingRight
	
	jmp dangerMovingLeft
ret
isInDangerZone ENDP

ResetColors PROC
	mov eax, white+(black*16)
	call settextcolor
ret
ResetColors ENDP
                           

;procedure to pause game						   
pauseIt PROC
jmp pauseLoop

returnBack:
	call crlf
	ret

pauseLoop:
	movzx eax, delaytime
	call delay
	mov cl, dl
	mov ch, dh
	call readkey
	mov dl,cl
	mov dh,ch
	mov bl, ah
	
	jz pauseLoop
	
	cmp bl, spacebar
	je returnBack

	jmp pauseLoop
ret
pauseIt ENDP


;main procedure
main PROC
call selectLevel
call playGame
call waitmsg
exit
main ENDP
END main