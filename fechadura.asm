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

MAIN:
	ACALL leituraTeclado
	JNB F0, MAIN     ; Se F0 não está setado, continua verificando teclado
	ACALL MOVER_20
	MOV A, R5
	CJNE A, #00h, CADASTRO
	CLR F0           ; Limpa o flag F0
	SJMP MAIN        ; Loop principal

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
	MOV R5, #01H
	ACALL delay
	RET

MOVER_24:
	MOV 24h, R0
	ACALL delay
	RET

CADASTRO:
	clr P1.3
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

delay:
MOV R7, #50
DJNZ R7, $
RET
