; --- Mapeamento de Hardware (8051) ---
    RS      equ     P1.3    ;Reg Select ligado em P1.3
    EN      equ     P1.2    ;Enable ligado em P1.2

    org 0000h
    LJMP START

START: ;sub-rotina para iniciar todos os valores da memoria em 0
	MOV 20h, #00h ;sao armazenados dos valores 20h a 24h o cadastro da senha da fechadura
  	MOV 21h, #00h
  	MOV 22h, #00h
  	MOV 23h, #00h
  	MOV 24h, #00h
  	MOV R5, #00H ;o valor de r5 define se a senha ja foi cadastrada ou nao
	MOV 50h, #00h ;sao armazenados dos valores 50h a 54h a entrada para destravar a fechadura
	MOV 51h, #00h
	MOV 52h, #00h
	MOV 53h, #00h
	MOV 54h, #00h
	MOV 60h, #00h ;o valor de 60h define se a senha esta correta ou nao

MAIN:
	CLR P2.7 
	MOV A, 54H
	CJNE A, #00h , COMPARAR ;salta para a funcao de comparar quando o usuario ja tiver cadastrado a senha, caso contrario o codigo continua
	;(ou seja, quando ja tiver digitado a senha de entrada para comparar com a senha cadastrada)
	MOV A, 24H
	CJNE A, #00h , conferirSenha ;salta para a funcao de conferir senha com a senha ja cadastrada, caso contrario o codigo continua
	;(ou seja, o usuario começa a digitar a senha de entrada)
	ACALL leituraTeclado ;chama (em loop) a funcao de leitura de teclado, caso uma tecla for pressionada, a leitura é feita
	JNB F0, MAIN ;caso nenhuma tecla foi pressionada, retorna para o menu e o loop continua
	ACALL MOVER_20 ;caso alguma tecla foi pressionada, é chamada a funcao de cadastrar a senha
	CLR F0
	SJMP MAIN ;retorna para main, para repetir o loop

conferirSenha: ;funcao semelhante ao de cadastrar senha, porem para pressionar os digitos de entrada de uma senha ja cadastrada
	SETB P2.7
	ACALL leituraTeclado
	JNB F0, conferirSenha
	ACALL MOVER_50
	CLR F0
	SJMP conferirSenha
	RET

CADASTRO: ;funcao para acender o LED amarelo quando a senha foi cadastrada
	clr P1.7
	lcall delay_maior
	lcall delay_maior
	lcall delay_maior
	setb p1.7
	RET

COMPARAR: ;funcao que compara o valor em 20h com 50h, em seguida 21h com 51h, 22h com 52h, em diante... 
	;Caso encontre valores diferentes, salta para a subrotina de erro, caso contrario, salta para a subrotina de acerto
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

acerto: ;funcao para quando o usuario acerta a senha cadastrada. Acende um LED verde e zera os valores entre 50h e 54h
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


erro: ;funcao para quando o usuario erra a senha cadastrada. Acende um LED vermelho e zera os valores entre 20h e 24h
	MOV 60H, #00H
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

MOVER_20: ;registra a tecla pressionada no endereco 20h, caso ela ja tenha um valor, vai para 21h
	MOV A, 20H
	CJNE A, #00H, MOVER_21
	MOV 20h, R0
	ACALL delay
	RET      

MOVER_21: ;registra a tecla pressionada no endereco 21h, caso ela ja tenha um valor, vai para 22h
	MOV A, 21H
	CJNE A, #00H, MOVER_22
	MOV 21h, R0
	ACALL delay
	RET  

MOVER_22: ;registra a tecla pressionada no endereco 22h, caso ela ja tenha um valor, vai para 23h
	MOV A, 22H
	CJNE A, #00H, MOVER_23
	MOV 22h, R0
	ACALL delay
	RET

MOVER_23: ;registra a tecla pressionada no endereco 23h, caso ela ja tenha um valor, vai para 24h
	MOV A, 23H
	CJNE A, #00H, MOVER_24
	MOV 23h, R0
	ACALL delay
	RET

MOVER_24: ;registra a tecla pressionada no endereco 24h e confirma que a senha foi cadastrada
	MOV 24h, R0
	ACALL delay
	ACALL delay
	ACALL CADASTRO
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


MOVER_50: ;registra a tecla pressionada no endereco 50h, caso ela ja tenha um valor, vai para 51h
	MOV A, 50H
	CJNE A, #00H, MOVER_51
	MOV 50h, R0
	ACALL delay
	RET      

MOVER_51: ;registra a tecla pressionada no endereco 51h, caso ela ja tenha um valor, vai para 52h
	MOV A, 51H
	CJNE A, #00H, MOVER_52
	MOV 51h, R0
	ACALL delay
	RET  

MOVER_52: ;registra a tecla pressionada no endereco 52h, caso ela ja tenha um valor, vai para 53h
	MOV A, 52H
	CJNE A, #00H, MOVER_53
	MOV 52h, R0
	ACALL delay
	RET

MOVER_53: ;registra a tecla pressionada no endereco 53h, caso ela ja tenha um valor, vai para 54h
	MOV A, 53H
	CJNE A, #00H, MOVER_54
	MOV 53h, R0
	MOV R5, #01H
	ACALL delay
	RET

MOVER_54: ;registra a tecla pressionada no endereco 54h e confirma que a senha de entrada foi digitada
	clr A
	MOV 54h, R0
	ACALL delay
	LCALL MAIN	

delay_maior: ;funcao de delay prolongado
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


delay: ;funcao de delay curto
	MOV R7, #50
	DJNZ R7, $
	RET