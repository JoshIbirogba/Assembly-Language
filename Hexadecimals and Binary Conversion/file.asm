mov dh, randBYTEX               ;;top row
			mov dl, randBYTEY
			call Gotoxy
			mov al, topLeft
			call WriteChar
			mov al, sideRight
			mov ECX, 7
			
			loop2:                          ;;loop to create horizontal characters
			      call WriteChar
				  loop loop2
			mov al, topRight
			call WriteChar
			
			mov EAX, randNumX              ;;resets the values of the random values of X and Y 
			mov randBYTEX, al
			mov EAX, randNumY
			inc EAX
			mov randBYTEY, AL 
			
			mov dh, randBYTEY             ;; middle horizontal 
			mov dl, randBYTEX
			call Gotoxy
			mov AL, sideright
			call WriteChar
			mov ECX, 2
			
			loop3:
			         inc randBYTEY                          ;middle vertical
					 mov dh, randBYTEY
					 mov dl, randBYTEX
					 call Gotoxy
					 mov AL, sideleft
					 call WriteChar
					 
					 mov al, sideleft
					 mov dh, randBYTEX
					 mov dl, randBYTEY
					 call Gotoxy
					 call WriteChar
					 mov ECX, 2
					 
					 loop4: inc randBYTEY
					 mov dh, randBYTEY
					 mov dl, randBYTEX
					 call Gotoxy
					 call WriteChar
					 loop loop4
					 
			mov EAX, randNumX
            mov randBYTEX, AL
           	mov EAX, randNumY
            add EAX, 4
            mov randBYTEY, Al

            mov dh, randBYTEY
            mov dl, randBYTEX
            call Gotoxy
            mov al, bottomLeft
            call WriteChar
            mov al, sideleft
            mov ECX, 7
        loop5:
            call WriteChar
            loop loop5
            mov al, bottomRight
     	    call WriteChar
            
            mov tmp, EAX
            mov EAX, 200
            call Delay
            mov EAX, tmp

        ret 