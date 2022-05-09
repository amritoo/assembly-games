.model small
.stack 100h

.data
chance DB 3
number DB 7
start DB 'You have 3 chances to guess the number, which is between 0 and 9.$'
promt DB 10, 10, 13, 'Guess a number: $'
outa DB 10, 13, 'You guessed too small!$'
outb DB 10, 13, 'You guessed too high!$'
outc DB 10, 10, 13, 'Congratulations you did it!$'
outd DB 10, 10, 13, 'The number is 7', 10, 13, 'Better Luck Next time!$'

.code

main PROC
    MOV AX, @data   ; load variables
    MOV DS, AX
    
    MOV AH, 9       ; print starting message
    LEA DX, start
    INT 21h
    
    MOV BH, chance
    
    while:          ; loop
    CMP BH, 0
    JE done:
    
    DEC BH
    
    MOV AH, 9       ; show promt
    LEA DX, promt
    INT 21h
    
    MOV AH, 1       ; input guess
    INT 21h
    MOV BL, AL
    SUB BL, 48
    
    CMP BL, number  ; compare guess with correct number
    JL less:
    JE congrats:
    JMP more:
    
    less:           ; guess is less than correct number
    MOV AH, 9
    LEA DX, outa
    INT 21h
    LOOP while:
    
    more:           ; guess is more than correct number
    MOV AH, 9
    LEA DX, outb
    INT 21h
    LOOP while:
    
    congrats:       ; guessed correct number
    MOV AH, 9
    LEA DX, outc
    INT 21h
    JMP exit:
    
    done:           ; could not guess correct number
    MOV AH, 9
    LEA DX, outd
    INT 21h
                   
    exit:           ; exit program
    MOV AH, 4ch
    INT 21h
    main ENDP
END main