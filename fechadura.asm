; --- Mapeamento de Hardware (8051) ---
    RS      equ     P1.3    ;Reg Select ligado em P1.3
    EN      equ     P1.2    ;Enable ligado em P1.2

    org 0000h
    LJMP START

START:
	MOV 20h, #00h
  	MOV 21h, #00h
  	MOV 22h, #00h
  	MOV 23h, #00h
  	MOV 24h, #00h
  	MOV R5, #00H
	MOV 50h, #00h
	MOV 51h, #00h
	MOV 52h, #00h
	MOV 53h, #00h
	MOV 54h, #00h
	MOV 60h, #00h

MAIN:
	CLR P2.7
	MOV A, 54H
	CJNE A, #00h , COMPARAR
	MOV A, 24H
	CJNE A, #00h , conferirSenha
	ACALL leituraTeclado
	JNB F0, MAIN
	ACALL MOVER_20
	MOV A, R5
	CJNE A, #00h, CADASTRO
	CLR F0
	SJMP MAIN

conferirSenha:
	MOV R2, #33h
	SETB P2.7
	ACALL leituraTeclado
	JNB F0, conferirSenha
	ACALL MOVER_50
	CLR F0
	SJMP conferirSenha
	RET

CADASTRO:
	clr P1.7
	lcall delay_maior
	lcall delay_maior
	lcall delay_maior
	setb p1.7
	RET

COMPARAR:
	MOV A, 20h
	CJNE A, 50h, erro
	lcall delay
	MOV A, 21h
	CJNE A, 51h, erro
	lcall delay
	MOV A, 22h
	CJNE A, 52h, erro
	lcall delay
	MOV A, 23h
	CJNE A, 53h, erro
	lcall delay
	acall acerto
	ret

acerto:
	CLR P1.5
	mov 60h, #01h
	MOV 54h, #00H
 	MOV 53h, #00H
 	MOV 52h, #00H
 	MOV 51h, #00H
 	MOV 50h, #00H
	lcall delay_maior
	lcall delay_maior
	lcall delay_maior
	SETB P1.5
	ret


erro:
	CLR P1.6
	MOV 54h, #00H
 	MOV 53h, #00H
 	MOV 52h, #00H
 	MOV 51h, #00H
 	MOV 50h, #00H
	lcall delay_maior
	lcall delay_maior
	lcall delay_maior
	SETB P1.6
	ret


ChamarMAIN:
	LJMP MAIN

MOVER_20:
	MOV A, 20H
	CJNE A, #00H, MOVER_21
	MOV 20h, R0
	ACALL delay
	RET      

MOVER_21:
	MOV A, 21H
	CJNE A, #00H, MOVER_22
	MOV 21h, R0
	ACALL delay
	RET  

MOVER_22:
	MOV A, 22H
	CJNE A, #00H, MOVER_23
	MOV 22h, R0
	ACALL delay
	RET

MOVER_23:
	MOV A, 23H
	CJNE A, #00H, MOVER_24
	MOV 23h, R0
	ACALL delay
	RET

MOVER_24:
	MOV 24h, R0
	ACALL delay
	ACALL delay
	RET




leituraTeclado:
  	MOV R0, #0       ; Reseta R0
  	MOV P0, #0FFh    ; Configura todas as linhas em alto

    ; Varre as linhas do teclado matricial
  	CLR P0.0         ; Limpa a linha 0
  	CALL colScan     ; Chama a sub-rotina para verificar colunas
  	JB F0, fimScan   ; Se F0 está setado, pula para o fim

  	SETB P0.0        ; Configura a linha 0 em alto
  	CLR P0.1         ; Limpa a linha 1
  	CALL colScan     ; Chama a sub-rotina para verificar colunas
	JB F0, fimScan   ; Se F0 está setado, pula para o fim

	SETB P0.1        ; Configura a linha 1 em alto
	CLR P0.2         ; Limpa a linha 2
	CALL colScan     ; Chama a sub-rotina para verificar colunas
	JB F0, fimScan   ; Se F0 está setado, pula para o fim

 	SETB P0.2        ; Configura a linha 2 em alto
  	CLR P0.3         ; Limpa a linha 3
  	CALL colScan     ; Chama a sub-rotina para verificar colunas
	JB F0, fimScan   ; Se F0 está setado, pula para o fim
		
fimScan:
	RET

colScan:
	JNB P0.4, keyFound ; Verifica coluna 0
	INC R0            ; Incrementa R0 se não encontrado
	JNB P0.5, keyFound ; Verifica coluna 1
	INC R0            ; Incrementa R0 se não encontrado
	JNB P0.6, keyFound ; Verifica coluna 2
  	INC R0            ; Incrementa R0 se não encontrado
 	RET

keyFound:
	SETB F0           ; Seta F0 indicando tecla encontrada
	RET


MOVER_50:
	MOV A, 50H
	CJNE A, #00H, MOVER_51
	MOV 50h, R0
	ACALL delay
	RET      

MOVER_51:
	MOV A, 51H
	CJNE A, #00H, MOVER_52
	MOV 51h, R0
	ACALL delay
	RET  

MOVER_52:
	MOV A, 52H
	CJNE A, #00H, MOVER_53
	MOV 52h, R0
	ACALL delay
	RET

MOVER_53:
	MOV A, 53H
	CJNE A, #00H, MOVER_54
	MOV 53h, R0
	MOV R5, #01H
	ACALL delay
	RET

MOVER_54:
	clr A
	MOV 54h, R0
	ACALL delay
	LCALL MAIN	

delay_maior:
	ACALL delay
	ACALL delay
	ACALL delay
	ACALL delay
	ACALL delay
	ACALL delay
	ACALL delay
	ACALL delay
	ACALL delay
	RET


delay:
	MOV R7, #50
	DJNZ R7, $
	RET