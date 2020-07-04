; Projecto AC

; Grupo 41

; Mário Reis, nº 70969
; Tiago Simões, nº 73100
; Miguel Oliveira, nº 73254


; ZONA I: Definição de constantes
;	Pseudo-instrução: 
;		EQU - Associa um valor const a um símbolo


SP_INICIAL      EQU     FDFFh
DISP_0		EQU	FFF0h				; Permite escrever no display de 7 segmentos mais à direita
DISP_1		EQU	FFF1h				; Idem para o display à esquerda do anterior
DISP_2		EQU	FFF2h				; Idem para o display à esquerda do anterior
DISP_3		EQU	FFF3h				; Idem para o display à esquerda do anterior
TIMER_COUNT	EQU	FFF6h				; Valor do contador associado ao temporizador
TIMER_INIT	EQU	FFF7h				; Temporizador ON / OFF
LEDS		EQU	FFF8h				; Permite acender os LED's
POSICAO_CUR	EQU	FFFCh				; Permite colocar o cursor numa dada posição da janela
IO_STATUS       EQU     FFFDh				; Permite testar se houve alguma tecla premida
IO_WRITE        EQU     FFFEh				; Permite escrever um caracter na janela
IO_READ         EQU     FFFFh				; Permite ler a última tecla premida

LSB_MASK	EQU	0001h				; Mascara para testar o bit menos significativo do Random_Var
RND_MASK	EQU	8016h				; 1000 0000 0001 0110b - Padrao de bits para geracao de numero aleatório
INT_MASK	EQU	801Fh				; 1000 0000 0001 1111b
INT_MASK_ADDR	EQU	FFFAh				; Porto controlo máscara de interrupções
ALAV_MASK_ADDR	EQU	FFF9h				; Permite ler nos 8 bits menos significativos o valor definido pela
							; posição dos interruptores

CalcDif		EQU	20				; Variável que serve para actualizar a dificuldade
N_LIN		EQU	14				; Altura do mapa de jogo
N_COL		EQU	21				; Largura do mapa de jogo

FIM_TEXTO       EQU     '!'				; Caracter Ascii que determina o final de uma string
FIM_NIVEL	EQU	'?'				; Caracter Ascii que determina o final de uma string

;------------------------------------------------------------------------------

; ZONA II: Definição de variaveis
;        Pseudo-instrucoes:
;		WORD - Reserva uma posição de memória para conter uma variável
;		STR - Coloca em posições de memória consecutivas o texto entre piclas
;		TAB - Reserva o número de posições de memória que se pretende

		ORIG	8000h

Random_Var	WORD	A5A5h
ALAV_MASK0	WORD	0000h
ALAV_MASK1	WORD	0001h
ALAV_MASK2	WORD	0002h
Direccao_Var	WORD	-1			; Variável que diz qual a direcção a percorrer

JOGO_DIM	TAB	294			; Variável que contém o mapa respectivo
POS_PACMAN	TAB	1			; Posição do PacMan no JOGO_DIM
POS_MONSTRO1	TAB	1			; Posição do Monstro 1 no JOGO_DIM
POS_MONSTRO2	TAB	1			; Posição do Monstro 2 no JOGO_DIM
POS_MONSTRO3	TAB	1			; Posição do Monstro 3 no JOGO_DIM
POS_MONSTRO4	TAB	1			; Posição do Monstro 4 no JOGO_DIM
POS_MONSTRO5	TAB	1			; Posição do Monstro 5 no JOGO_DIM

Pos		TAB	1			; Posição do cursor na janela de texto
Posx		TAB	1			; Variável que guarda a coluna do cursor da janela de texto
Posy		TAB	1			; Variável que guarda a linha do cursor da janela de texto
HScore		TAB	1			; Pontuação máxima
Score		TAB	1			; Pontuação actual
Interrupcao_Var	TAB	1			; Variável que serve para indicar se ocorreu uma interrupção
Nivel_?		TAB	1			; Variável que guarda o número do nivel
Dif		TAB	1			; Variável que guarda a dificuldade
Velocidade	TAB	1			; Variável que guarda a velocidade
Pontos_Var	TAB	1			; Variável que guarda os pontos de um nivel
Nivel_Actual	TAB	1			; Variável que indica o nivel actual

Titulo		STR     'Jogo Pac-Man', FIM_TEXTO
PMax	        STR     'Pontuacao maxima: ', FIM_TEXTO
EscNivel_0      STR     'Use as alavancas para escolher o nivel inicial', FIM_TEXTO
EscNivel_1      STR     'e em seguida prima uma tecla.', FIM_TEXTO
Nivel		STR	'Nivel ', FIM_TEXTO
Espera_0	STR	'Premir uma tecla para', FIM_TEXTO
Espera_1	STR	'comecar o jogo.', FIM_TEXTO
Espera_2	STR	'comecar o proximo nivel.', FIM_TEXTO
GAMEOVER        STR     'GAME OVER :(', FIM_TEXTO

;------------------------------------------------------------------------------

; Mapa correspondente ao nivel 1

			;012345678901234567890
Nivel1_L0	STR	'#####################', FIM_TEXTO
Nivel1_L1	STR	'#&........M........%#', FIM_TEXTO
Nivel1_L2	STR	'#.#####..#.#..#####.#', FIM_TEXTO
Nivel1_L3	STR	'#.#...#..#.#..#...#.#', FIM_TEXTO
Nivel1_L4	STR	'#.#.#.#..#.#..#.#.#.#', FIM_TEXTO
Nivel1_L5	STR	'#...................#', FIM_TEXTO
Nivel1_L6	STR	'##.####.#.).#.####.##', FIM_TEXTO
Nivel1_L7	STR	'##.####.#####.####.##', FIM_TEXTO
Nivel1_L8	STR	'#...................#', FIM_TEXTO
Nivel1_L9	STR	'#.#.#.#..#.#..#.#.#.#', FIM_TEXTO
Nivel1_L10	STR	'#.#...#..#.#..#...#.#', FIM_TEXTO
Nivel1_L11	STR	'#.#####..#.#..#####.#', FIM_TEXTO
Nivel1_L12	STR	'#.........@.........#', FIM_TEXTO
Nivel1_L13	STR	'#####################', FIM_NIVEL

;------------------------------------------------------------------------------

; Mapa correspondente ao nivel 2

			;012345678901234567890
Nivel2_L0	STR	'#####################', FIM_TEXTO
Nivel2_L1	STR	'#.........@.........#', FIM_TEXTO
Nivel2_L2	STR	'#.#####..###..#####.#', FIM_TEXTO
Nivel2_L3	STR	'#.#...#..#.#..#...#.#', FIM_TEXTO
Nivel2_L4	STR	'#.#.#.#..#.#..#.#.#.#', FIM_TEXTO
Nivel2_L5	STR	'#..................M#', FIM_TEXTO
Nivel2_L6	STR	'##.####.#####.####.##', FIM_TEXTO
Nivel2_L7	STR	'##.#.##.#.).#.##.#.##', FIM_TEXTO
Nivel2_L8	STR	'#M..................#', FIM_TEXTO
Nivel2_L9	STR	'#.########.########.#', FIM_TEXTO
Nivel2_L10	STR	'#.#.&.#..#.#..#.%.#.#', FIM_TEXTO
Nivel2_L11	STR	'#.##.##..#.#..##.##.#', FIM_TEXTO
Nivel2_L12	STR	'#.........M.........#', FIM_TEXTO
Nivel2_L13	STR	'#####################', FIM_NIVEL

;------------------------------------------------------------------------------

; Mapa correspondente ao nivel 3

			;012345678901234567890
Nivel3_L0	STR	'#####################', FIM_TEXTO
Nivel3_L1	STR	'#..M.............M..#', FIM_TEXTO
Nivel3_L2	STR	'#.#####..#.#..#####.#', FIM_TEXTO
Nivel3_L3	STR	'#.#......#.#......#.#', FIM_TEXTO
Nivel3_L4	STR	'#.#####..###..#####.#', FIM_TEXTO
Nivel3_L5	STR	'#M..................#', FIM_TEXTO
Nivel3_L6	STR	'##.#..####@####..#.##', FIM_TEXTO
Nivel3_L7	STR	'##.####..###..####.##', FIM_TEXTO
Nivel3_L8	STR	'#..................M#', FIM_TEXTO
Nivel3_L9	STR	'#######.#.#.#.#######', FIM_TEXTO
Nivel3_L10	STR	'#&#...#.#.).#.#...#%#', FIM_TEXTO
Nivel3_L11	STR	'#.##.##.#####.##.##.#', FIM_TEXTO
Nivel3_L12	STR	'#.........M.........#', FIM_TEXTO
Nivel3_L13	STR	'#####################', FIM_NIVEL

;------------------------------------------------------------------------------

; Tabela de interrupções
                
		ORIG	FE00h
INT0		WORD	IntMoveW
INT1		WORD	IntMoveS
INT2		WORD	IntMoveO
INT3		WORD	IntMoveP
INT4		WORD	IntPause

		ORIG	FE0Fh
INT15		WORD	IntMove

;------------------------------------------------------------------------------

; ZONA III: codigo
;        conjunto de instrucoes Assembly, ordenadas de forma a realizar
;        as funcoes pretendidas

                ORIG    0000h
                JMP     Inicio

;------------------------------------------------------------------------------

; PACMAN_INICIO: Rotina que inicializa a posição do Pac-Man no campo JOGO_DIM.

PACMAN_INICIO:	PUSH    R1
		PUSH	R3
		MOV	R3, JOGO_DIM
PacManLoop:	MOV     R1, M[R3]
		CMP     R1, '@'
		BR.Z    FimPacman
		INC     R3
		BR      PacManLoop
FimPacman:	MOV	M[POS_PACMAN], R3
		POP	R3
		POP     R1
		RET

;------------------------------------------------------------------------------

; MONSTROS_INIC: Rotina que inicializa as posições do(s) Monstro(s) no campo JOGO_DIM.

MONSTROS_INIC:	PUSH    R1
		PUSH	R3
		MOV	R3, JOGO_DIM
MonstroLoop:	MOV     R1, M[R3]
		CMP     R1, 'M'
		BR.Z    GuardaMonstro
		INC     R3
		BR      MonstroLoop
GuardaMonstro:	MOV	M[POS_MONSTRO1], R3
		INC	R3
MonstroLoop2:	MOV     R1, M[R3]
		CMP     R1, 'M'
		BR.Z    GuardaMonstro2
		CMP	R1, FIM_NIVEL
		JMP.Z	FimMonstro
		INC     R3
		BR      MonstroLoop2
GuardaMonstro2:	MOV	M[POS_MONSTRO2], R3
		INC	R3
MonstroLoop3:	MOV     R1, M[R3]
		CMP     R1, 'M'
		BR.Z    GuardaMonstro3
		CMP	R1, FIM_NIVEL
		BR.Z	FimMonstro
		INC     R3
		BR      MonstroLoop3
GuardaMonstro3:	MOV	M[POS_MONSTRO3], R3
		INC	R3
MonstroLoop4:	MOV     R1, M[R3]
		CMP     R1, 'M'
		BR.Z    GuardaMonstro4
		CMP	R1, FIM_NIVEL
		BR.Z	FimMonstro
		INC     R3
		BR      MonstroLoop4
GuardaMonstro4:	MOV	M[POS_MONSTRO4], R3
		INC	R3
MonstroLoop5:	MOV     R1, M[R3]
		CMP     R1, 'M'
		BR.Z    GuardaMonstro5
		CMP	R1, FIM_NIVEL
		BR.Z	FimMonstro
		INC     R3
		BR      MonstroLoop5
GuardaMonstro5:	MOV	M[POS_MONSTRO5], R3
FimMonstro:	POP	R3
		POP     R1
		RET

;------------------------------------------------------------------------------

; IntMoveW: Rotina de interrupção que move 0h para a variável que diz qual a direcção a percorrer

IntMoveW:	PUSH	R1
		MOV	R1, 0000h
		MOV	M[Direccao_Var], R1
		POP	R1
		RTI

;------------------------------------------------------------------------------

; IntMoveS: Rotina de interrupção que move 1h para a variável que diz qual a direcção a percorrer

IntMoveS:	PUSH	R1
		MOV	R1, 0001h
		MOV	M[Direccao_Var], R1
		POP	R1
		RTI

;------------------------------------------------------------------------------

; IntMoveO: Rotina de interrupção que move 2h para a variável que diz qual a direcção a percorrer

IntMoveO:	PUSH	R1
		MOV	R1, 0010h
		MOV	M[Direccao_Var], R1
		POP	R1
		RTI

;------------------------------------------------------------------------------

; IntMoveP: Rotina de interrupção que move 3h para a variável que diz qual a direcção a percorrer

IntMoveP:	PUSH	R1
		MOV	R1, 0011h
		MOV	M[Direccao_Var], R1
		POP	R1
		RTI

;------------------------------------------------------------------------------

; IntPause: Rotina de interrupção que pára o jogo em qualquer altura e continua quando
;		efectua a leitura de um caracter proveniente do teclado.

IntPause:	CALL	LeCar
		RTI

;------------------------------------------------------------------------------

; IntMove: Rotina de interrupção que arranca o temporizador e actualiza o valor do contador
;		associado ao temporizador através da variável velocidade. Esta rotina
;		também mete a variável que serve para indicar que ocorreu uma interrupção a zero.

IntMove:	CALL	ActivaTempo
		MOV	M[Interrupcao_Var], R0
		RTI

;------------------------------------------------------------------------------

; IniDireccao: Rotina que irá escolher a direcção que o Pac-Man irá tomar dependendo
;		da tecla que foi premida.

IniDireccao:	PUSH	R1
		MOV	R1, M[Direccao_Var]
		CMP 	R1, 0000h
		CALL.Z	BOTAO_W
		CMP 	R1, 0001h
		CALL.Z 	BOTAO_S
		CMP	R1, 0010h
		CALL.Z	BOTAO_O
		CMP 	R1, 0011h
		CALL.Z 	BOTAO_P
		CALL	MoveMonstro
		POP	R1
		RET

;------------------------------------------------------------------------------

; BOTAO_W: Rotina que move o Pac-Man para cima e, caso seja uma parede, não se mexe.
;		Caso contrário, irá incrementar a peça comida à pontuação actual e actualizar as
;		respectivas variáveis.

BOTAO_W:	PUSH	R1
		PUSH	R2
		MOV	R1, M[POS_PACMAN]
		SUB	R1, 15h
		MOV	R2, '#'
		CMP	M[R1], R2
		BR.Z	NaoMove_W
		CALL	IncPecasCom
		ADD	R1, 15h
		MOV	R2, M[R1]
		MOV	M[R1], R0
		SUB	R1, 15h
		MOV	M[R1], R2
		MOV	M[POS_PACMAN], R1
		MOV	R1, M[Pos]
		PUSH	R1
		CALL	ApagaCar
		MOV	R1, M[Pos]
		CALL	SobeLin
		MOV	R1, '@'
		PUSH	R1
		CALL	EscCar
NaoMove_W:	POP	R2
		POP	R1
		RET

; BOTAO_S: Rotina que move o Pac-Man para baixo e, caso seja uma parede, não se mexe.
;		Caso contrário, irá incrementar a peça comida à pontuação actual e actualizar as
;		respectivas variáveis.

BOTAO_S:	PUSH	R1
		PUSH	R2
		MOV	R1, M[POS_PACMAN]
		ADD	R1, 15h
		MOV	R2, '#'
		CMP	M[R1], R2
		BR.Z	NaoMove_S
		CALL	IncPecasCom
		SUB	R1, 15h
		MOV	R2, M[R1]
		MOV	M[R1], R0
		ADD	R1, 15h
		MOV	M[R1], R2
		MOV	M[POS_PACMAN], R1
		MOV	R1, M[Pos]
		PUSH	R1
		CALL	ApagaCar
		MOV	R1, M[Pos]
		CALL	MudaLin
		MOV	R1, '@'
		PUSH	R1
		CALL	EscCar
NaoMove_S:	POP	R2
		POP	R1
		RET

; BOTAO_O: Rotina que move o Pac-Man para a esquerda e, caso seja uma parede, não se mexe.
;		Caso contrário, irá incrementar a peça comida à pontuação actual e actualizar as
;		respectivas variáveis.

BOTAO_O:	PUSH	R1
		PUSH	R2
		MOV	R1, M[POS_PACMAN]
		DEC	R1
		MOV	R2, '#'
		CMP	M[R1], R2
		BR.Z	NaoMove_O
		CALL	IncPecasCom
		INC	R1
		MOV	R2, M[R1]
		MOV	M[R1], R0
		DEC	R1
		MOV	M[R1], R2
		MOV	M[POS_PACMAN], R1
		MOV	R1, M[Pos]
		PUSH	R1
		CALL	ApagaCar
		MOV	R1, M[Pos]
		CALL	MudaColE
		MOV	R1, '@'
		PUSH	R1
		CALL	EscCar
NaoMove_O:	POP	R2
		POP	R1
		RET

; BOTAO_P: Rotina que move o Pac-Man para a direita e, caso seja uma parede, não se mexe.
;		Caso contrário, irá incrementar a peça comida à pontuação actual e actualizar as
;		respectivas variáveis.

BOTAO_P:	PUSH	R1
		PUSH	R2
		MOV	R1, M[POS_PACMAN]
		INC	R1
		MOV	R2, '#'
		CMP	M[R1], R2
		BR.Z	NaoMove_P
		CALL	IncPecasCom
		DEC	R1
		MOV	R2, M[R1]
		MOV	M[R1], R0
		INC	R1
		MOV	M[R1], R2
		MOV	M[POS_PACMAN], R1
		MOV	R1, M[Pos]
		PUSH	R1
		CALL	ApagaCar
		MOV	R1, M[Pos]
		CALL	MudaColD
		MOV	R1, '@'
		PUSH	R1
		CALL	EscCar
NaoMove_P:	POP	R2
		POP	R1
		RET

;------------------------------------------------------------------------------

; IncPecasCom: Rotina que verifica se é um monstro, um ponto, uma banana, uma pêra e um gelado.
;		Esta rotina também irá converter a pontuação de hexadecimal para decimal e meter
;		nos respectivos displays, e irá actualizar a dificuldade, velocidade e os LEDS.

IncPecasCom:	PUSH	R1
		PUSH	R2
		MOV	R2, 'M'
		CMP	M[R1], R2
		CALL.Z	MonstroGO
		MOV	R2, '.'
		CMP	M[R1], R2
		CALL.Z	IncPonto
		MOV	R2, ')'
		CMP	M[R1], R2
		CALL.Z	IncBanana
		MOV	R2, '&'
		CMP	M[R1], R2
		CALL.Z	IncPera
		MOV	R2, '%'
		CMP	M[R1], R2
		CALL.Z	IncGelado
		CALL	ConvertHex
		CALL	ActualizaDif
		CALL	ActualizaLeds
		POP	R2
		POP	R1
		RET

;------------------------------------------------------------------------------

; IncPonto: Rotina que aumenta 2h à pontuação actual e decrementa 1h à variável que contém os pontos.

IncPonto:	PUSH	R1
		DEC	M[Pontos_Var]
		MOV	R1, M[Score]
		ADD	R1, 2h
		MOV	M[Score], R1
		POP	R1
		RET

;------------------------------------------------------------------------------

; IncBanana: Rotina que aumenta Ah à pontuação actual.

IncBanana:	PUSH	R1
		MOV	R1, M[Score]
		ADD	R1, Ah
		MOV	M[Score], R1
		POP	R1
		RET

;------------------------------------------------------------------------------

; IncPera: Rotina que aumenta 14h à pontuação actual.

IncPera:	PUSH	R1
		MOV	R1, M[Score]
		ADD	R1, 14h
		MOV	M[Score], R1
		POP	R1
		RET

;------------------------------------------------------------------------------

; IncGelado: Rotina que aumenta 1Eh à pontuação actual.

IncGelado:	PUSH	R1
		MOV	R1, M[Score]
		ADD	R1, 1Eh
		MOV	M[Score], R1
		POP	R1
		RET

;------------------------------------------------------------------------------

; ConvertHex: Rotina que efectua a conversão de hexadecimal para decimal da variável pontuação actual
;		e mete directamente nos displays respectivos.

ConvertHex:	PUSH	R1
		PUSH	R2
		MOV	R1, M[Score]
		MOV	R2, 000Ah
		DIV	R1, R2
		MOV	M[DISP_0], R2
		MOV	R2, 000Ah
		DIV	R1, R2
		MOV	M[DISP_1], R2
		MOV	R2, 000Ah
		DIV	R1, R2
		MOV	M[DISP_2], R2
		POP	R2
		POP	R1
		RET

;------------------------------------------------------------------------------

; AcabaNivel: Rotina que vê quando a variável que contém os pontos chega a zero, caso isso aconteca,
;		actualiza a pontuação máxima, escreve as strings  Espera_0 e Espera_2 na janela de texto,
;		inicializa os displays e LEDS a zero e passa para o nivel seguinte.

AcabaNivel:	PUSH	R1
		MOV	R1, M[Pontos_Var]
		CMP	R1, R0
		BR.NZ	Acaba
		CALL	ActualizaHscore
		CALL	EscEspera
		CALL	LeCar
		MOV	M[DISP_0], R0
		MOV	M[DISP_1], R0
		MOV	M[DISP_2], R0
		MOV	M[LEDS], R0
		CALL	ALAVANCAS_LOOP
Acaba:		POP	R1
		RET

;------------------------------------------------------------------------------

; MonstroGO: Rotina que actualiza a variável HScore, efectua a escrita da string GAMEOVER,
;		mete os LEDS a zero, e inicia um novo jogo onde se escolhe novamente o nivel
;		que se pretende jogar.

MonstroGO:	CALL	ActualizaHscore
		CALL	GameOver
		CALL	LeCar
		MOV	M[LEDS], R0
		CALL	TextoInicLoop
		RET

;------------------------------------------------------------------------------

; LeCar: Rotina que efectua a leitura de um caracter proveniente do teclado.

LeCar:          CMP     R0, M[IO_STATUS]
                BR.Z    LeCar
                MOV     R1, M[IO_READ]
                RET

;------------------------------------------------------------------------------

; ActualizaHscore: Rotina que actualiza a pontuação máxima consoante o Score obtido.

ActualizaHscore:	PUSH	R1
			PUSH	R2
			MOV	R1, M[Score]
			MOV	R2, M[HScore]
			CMP	R2, R1
			BR.P	HScoreLoop
			MOV	R1, M[Score]
			MOV	M[HScore], R1
HScoreLoop:		POP	R2
			POP	R1
			RET

;------------------------------------------------------------------------------

; EscHScore: Rotina que efectua a conversão de hexadecimal para decimal da variável HScore
;		e efectua a escrita da mesma na janela de texto

EscHScore:	PUSH	R1
		PUSH	R2
		MOV	R1, M[HScore]
		MOV	R2, 000Ah
		DIV	R1, R2
		ADD	R2, 30h
		PUSH	R2
		MOV	R2, 000Ah
		DIV	R1, R2
		ADD	R2, 30h
		PUSH	R2
		MOV	R2, 000Ah
		DIV	R1, R2
		ADD	R2, 30h
		PUSH	R2
		MOV	R2, 000Ah
		DIV	R1, R2
		ADD	R2, 30h
		PUSH	R2
		POP	R2
		MOV	M[IO_WRITE], R2
		CALL	MudaColD
		POP	R2
		MOV	M[IO_WRITE], R2
		CALL	MudaColD
		POP	R2
		MOV	M[IO_WRITE], R2
		CALL	MudaColD
		POP	R2
		MOV	M[IO_WRITE], R2
		POP	R2
		POP	R1
		RET

;------------------------------------------------------------------------------

; EscCar: Rotina que efectua a escrita de um caracter para o ecran.
;       O caracter pode ser visualizado na janela de texto.

EscCar:         MOV     R1, M[SP+2]
                MOV     M[IO_WRITE], R1
                RETN    1

;------------------------------------------------------------------------------

; EscTextoInic: Rotina que apaga a janela de texto, escreve a pontuação máxima e efectua a escrita
;		das strings Titulo, PMax, EscNivel_0 e EscNivel_1 na janela de texto.

EscTextoInic:   CALL	LimpaJT
		PUSH	R1
		PUSH	R2
		MOV	R2, Titulo
		MOV	R1, 0000h
		MOV	M[POSICAO_CUR], R1
		MOV	M[Pos], R1
		CALL	EscString
		MOV	R2, PMax
		MOV	R1, 0200h
		MOV	M[POSICAO_CUR], R1
		MOV	M[Pos], R1
		CALL	EscString
		CALL	EscHScore				; Escreve a pontuação máxima logo a seguir à string PMax
		MOV	R2, EscNivel_0
		MOV	R1, 0400h
		MOV	M[POSICAO_CUR], R1
		MOV	M[Pos], R1
		CALL	EscString
		MOV	R2, EscNivel_1
		MOV	R1, 0500h
		MOV	M[POSICAO_CUR], R1
		MOV	M[Pos], R1
		CALL	EscString
		POP	R2
		POP	R1
		RET

;------------------------------------------------------------------------------

; EscTextoMapa: Rotina que efectua a escrita das strings Titulo, Nivel, Espera_0
;		e Espera_1 com as respectivas coordenadas na janela de texto.

EscTextoMapa:	PUSH	R1
		PUSH	R2
		MOV	R2, Titulo
		MOV	R1, 011Eh
		MOV	M[POSICAO_CUR], R1
		MOV	M[Pos], R1
		CALL	EscString
		MOV	R2, Nivel
		MOV	R1, 0721h
		MOV	M[POSICAO_CUR], R1
		MOV	M[Pos], R1
		CALL	EscString
		MOV	R2, M[Nivel_?]
		PUSH	R2
		CALL 	EscCar					; Escreve o número do nivel logo a seguir à string Nivel
		MOV	R2, Espera_0
		MOV	R1, 0A1Bh
		MOV	M[POSICAO_CUR], R1
		MOV	M[Pos], R1
		CALL	EscString
		MOV	R2, Espera_1
		MOV	R1, 0B1Bh
		MOV	M[POSICAO_CUR], R1
		MOV	M[Pos], R1
		CALL	EscString
		POP	R2
		POP	R1
		RET

;------------------------------------------------------------------------------

; LimpaJT: Rotina que limpa a janela de texto.

LimpaJT:	MOV 	R1, IO_READ				;Rotina que limpa a janela de texto
		MOV 	M[POSICAO_CUR], R1
		RET

;------------------------------------------------------------------------------

; EscString: Rotina que efectua a escrita de uma cadeia de caracter, terminada
;          pelo caracter FIM_TEXTO. Pode-se definir como terminador qualquer
;          caracter ASCII. Esta rotina também incrementa o cursor da janela de
;          texto de modo a que o cursor seja posicionado na posição seguinte
;          à medida que o caracter se vai alterando.

EscString:	PUSH    R1
		PUSH    R2
Ciclo:		MOV     R1, M[R2]
		CMP     R1, FIM_TEXTO
		BR.Z    FimEsc
		PUSH    R1
		CALL    EscCar
		CALL	MudaColD
		INC     R2
		BR      Ciclo
FimEsc:		POP     R2
		POP     R1
		RET

;--------------------------------------------------------------------------------

; EscMapa: Rotina que efectua a escrita do respectivo Mapa

EscMapa:	PUSH	R1
		PUSH	R2
		PUSH	R3
		MOV	R1, 0000h
		MOV	M[POSICAO_CUR], R1
		MOV	M[Pos], R1
		MOV	R3, JOGO_DIM
CCiclo:		MOV     R1, M[R2]
		MOV	M[R3], R1
		CMP	R1, FIM_NIVEL
		BR.Z	FimNivel
                CMP     R1, FIM_TEXTO
                BR.Z    CNivel
                PUSH    R1
                CALL    EscCar
		CMP     R1, '.'
		BR.NZ   NaoIncrementa
		INC	M[Pontos_Var]	
NaoIncrementa:	CALL	MudaColD
		INC	R3
		INC     R2
                BR      CCiclo
CNivel:     	CALL	NovaLin
		INC	R2
		BR	CCiclo
FimNivel:	POP	R3
		POP     R2
                POP     R1
		RET

;------------------------------------------------------------------------------

; SobeLin: Rotina que sobe uma linha no cursor na janela de texto.

SobeLin:	PUSH	R1
		PUSH	R2
		MOV	R1, M[Pos]
		MOV	R2, 0100h
		SUB	R1, R2
		MOV	M[Pos], R1
		MOV	M[POSICAO_CUR], R1
		SHR	R1, 8
		MOV	M[Posy], R1
		POP	R2
		POP	R1
		RET

;------------------------------------------------------------------------------

; MudaLin: Rotina que baixa uma linha no cursor na janela de texto.

MudaLin:	PUSH	R1
		PUSH	R2
		MOV	R1, M[Pos]
		MOV	R2, 0100h
		ADD	R1, R2
		MOV	M[Pos], R1
		MOV	M[POSICAO_CUR], R1
		SHR	R1, 8
		MOV	M[Posy], R1
		POP	R2
		POP	R1
		RET
;------------------------------------------------------------------------------

; MudaColD: Rotina que incrementa o cursor na janela de texto.

MudaColD:	PUSH    R1
		MOV	R1, M[Pos]
        	INC	R1
	        MOV	M[Pos], R1
		MOV	M[POSICAO_CUR], R1
		MOV	M[Posx], R1
        	POP     R1
	        RET

;------------------------------------------------------------------------------

; MudaColE: Rotina que decrementa o cursor na janela de texto.

MudaColE:	PUSH    R1
		PUSH	R2
		MOV	R1, M[Pos]
        	DEC	R1
	        MOV	M[Pos], R1
		MOV	M[POSICAO_CUR], R1
		MOV	R2, 00FFh
		AND	R1, R2
		MOV	M[Posx], R1
        	POP     R2
		POP	R1
	        RET

;------------------------------------------------------------------------------

; NovaLin: Rotina que muda o cursor para o início da linha seguinte na janela de texto.

NovaLin:    	PUSH	R1
		PUSH	R2
		MOV	R1, R0
		INC	R1
		MOV	M[Posx], R1
        	MOV     R1, M[Pos]
	        MOV     R2, FF00h
        	AND     R1, R2
	        MOV     R2, 0100h
        	ADD     R1, R2
		MOV	M[Posy], R1
	        MOV     M[Pos], R1
		MOV	M[POSICAO_CUR], R1
		POP	R2
		POP	R1
		RET

;------------------------------------------------------------------------------

; EscEspera: Rotina que efectua a escrita das strings Espera_0 e Espera_2 da janela de texto.

EscEspera:	PUSH	R1
		PUSH	R2
		MOV	R2, Espera_0
		MOV	R1, 0A1Bh
		MOV	M[POSICAO_CUR], R1
		MOV	M[Pos], R1
		CALL	EscString
		MOV	R2, Espera_2
		MOV	R1, 0B1Bh
		MOV	M[POSICAO_CUR], R1
		MOV	M[Pos], R1
		CALL	EscString
		POP	R2
		POP	R1
		RET

;------------------------------------------------------------------------------

; ApagaEspera: Rotina que apaga as strings Espera_0 e Espera_1 da janela de texto.

ApagaEspera:	PUSH	R1
		PUSH	R2
		MOV	R2, Espera_0
		MOV	R1, 0A1Bh
		MOV	M[POSICAO_CUR], R1
		MOV	M[Pos], R1
		CALL	ApagaString
		MOV	R2, Espera_1
		MOV	R1, 0B1Bh
		MOV	M[POSICAO_CUR], R1
		MOV	M[Pos], R1
		CALL	ApagaString
		POP	R2
		POP	R1
		RET

;------------------------------------------------------------------------------

; ApagaString: Rotina que apaga uma string da janela de texto.

ApagaString:	PUSH    R1
		PUSH    R2
ApagaLoop:	MOV     R1, M[R2]
		CMP     R1, FIM_TEXTO
		BR.Z    ApagaFim
		PUSH    R1
		CALL    ApagaCar
		CALL	MudaColD
		INC     R2
		BR      ApagaLoop
ApagaFim:	POP     R2
		POP     R1
		RET

;------------------------------------------------------------------------------

; ApagaCar: Rotina que apaga um caracter da janela de texto.

ApagaCar:	MOV     R1, 0020h
                MOV     M[IO_WRITE], R1
                RETN    1

;------------------------------------------------------------------------------

; GameOver: Rotina que efectua a escrita da string GAMEOVER na janela de texto. 

GameOver:	PUSH	R1
		PUSH	R2
		MOV	R2, GAMEOVER
		MOV	R1, 0A20h
		MOV	M[POSICAO_CUR], R1
		MOV	M[Pos], R1
		CALL	EscString
		POP	R2
		POP	R1
		RET

;------------------------------------------------------------------------------

; ActualizaLeds: Rotina que actualiza os LEDS de dificuldade consoante o Score obtido.

ActualizaLeds:	PUSH	R1
		PUSH	R2
		PUSH	R3
		MOV	R1, M[Score]
		MOV	R2, CalcDif
		MOV	R3, 0007h
		DIV	R1, R2
		MOV	R2, 0001h
ALLoop:		DEC	R1
		BR.N	ALFim
		SHL	R2, 1
		INC	R2
		DEC	R3
		BR.Z	ALFim
		BR	ALLoop
ALFim:		MOV	M[LEDS], R2
		POP	R3
		POP	R2
		POP	R1
		RET

;------------------------------------------------------------------------------

; ActivaTempo: Rotina que arranca o temporizador e actualiza o valor do contador associado ao temporizador
;		através da variável velocidade.

ActivaTempo:	PUSH	R1
		MOV	R1, 0001h
		MOV	M[TIMER_INIT], R1
		MOV	R1, M[Velocidade]
		MOV	M[TIMER_COUNT], R1
		POP	R1
		ENI
		RET

;------------------------------------------------------------------------------

; ActualizaDif: Rotina que actualiza as variáveis dificuldade e velocidade com base nas pecas comidas.

ActualizaDif:	PUSH	R1
		PUSH	R2
		MOV	R1, 0007h
		MOV	R2, M[Dif]
		CMP	R2, R1
		BR.Z	ADIgnora
 		MOV	R1, M[Score]
		MOV	R2, CalcDif
		DIV	R1, R2
		MOV	M[Dif], R1
		MOV	R2, 000Ah
		SUB	R2, R1
		MOV	M[Velocidade], R2
ADIgnora:	POP	R2
		POP	R1
		RET

;------------------------------------------------------------------------------

; InitDif: Rotina que inicializa a variáveis dificuldade e pontuação actual a zero,
;		e inicializa a dificuldade no mínimo.

InitDif:	PUSH	R1
		MOV	R1, Ah
		MOV	M[Dif], R0
		MOV	M[Score], R0
		MOV	M[Velocidade], R1
		MOV	R1, -1
		MOV	M[Direccao_Var], R1
		POP	R1
		RET

;------------------------------------------------------------------------------

; MoveMonstro: Rotina que gera um número random e com esse número escolhe a direcção
;		do(s) Monstro(s).

MoveMonstro:	PUSH	R1
		PUSH	R2
		I1OP	M[Random_Var]
		MOV	R1, M[Random_Var]
		MOV	R2, 0003h
		AND	R1, R2
		CMP 	R1, 0000h
		CALL.Z	MoveMonstro_W
		CMP 	R1, 0001h
		CALL.Z	MoveMonstro_S
		CMP 	R1, 0010h
		CALL.Z	MoveMonstro_O
		CMP	R1, 0011h
		CALL.Z	MoveMonstro_P
		POP	R2
		POP	R1
		RET

;------------------------------------------------------------------------------

; MoveMonstro_W: Rotina INACABADA que iria tratar do movimento do Monstro para cima.

MoveMonstro_W:	RET

;------------------------------------------------------------------------------

; MoveMonstro_S: Rotina INACABADA que iria tratar do movimento do Monstro para baixo.

MoveMonstro_S:	RET

;------------------------------------------------------------------------------

; MoveMonstro_O: Rotina INACABADA que iria tratar do movimento do Monstro para a esquerda.

MoveMonstro_O:	RET


;------------------------------------------------------------------------------

; MoveMonstro_P: Rotina INACABADA que iria tratar do movimento do Monstro para a direita.

MoveMonstro_P:	RET

;------------------------------------------------------------------------------

; ALAVANCAS_LOOP: Rotina que inicia a dificuldade e escolhe os mapas após a passagem de nivel.

ALAVANCAS_LOOP:	CALL	InitDif
		MOV	R1, M[Nivel_Actual]
		CMP 	R1, 0000h
		CALL.Z	CallNivel2
		CMP 	R1, 0001h
		CALL.Z	CallNivel3
		CMP 	R1, 0010h
		CALL.Z	CallNivel3
		RET

;------------------------------------------------------------------------------

; ALAVANCAS_MAIN: Rotina que inicia a dificuldade e escolhe o mapa inicial consoante os interruptores de alavanca.
;		Apenas são relevantes os dois interruptores mais à direita (os menos significativos).

ALAVANCAS_MAIN:	CALL	InitDif
		MOV	R1, M[ALAV_MASK_ADDR]
		CMP	R1, M[ALAV_MASK0]
		CALL.Z	CallNivel1
		CMP	R1, M[ALAV_MASK1]
		CALL.Z	CallNivel2
		CMP	R1, M[ALAV_MASK2]
		CALL.Z	CallNivel3
		RET

;------------------------------------------------------------------------------

; CallNivel1: Rotina que apaga a janela de texto, escreve o mapa de nivel 1 e as respectivas mensagens,
;		apaga as strings Espera_0 e Espera_1, e inicializa as posicões do Pacman e Montro no campo JOGO_DIM

CallNivel1:	MOV	R1, 0000h
		MOV	M[Nivel_Actual], R1
		CALL	LimpaJT
		MOV	M[Pontos_Var], R0
		MOV	R2, Nivel1_L0
		CALL	EscMapa
		MOV	R1, 31h
		MOV	M[Nivel_?], R1
		CALL	EscTextoMapa
		CALL	LeCar
		CALL	ApagaEspera
		CALL	MONSTROS_INIC
		CALL	PACMAN_INICIO
		MOV	R1, 0C0Ah
		MOV	M[POSICAO_CUR], R1
		MOV	M[Pos], R1
		RET

;------------------------------------------------------------------------------

; CallNivel2: Rotina que apaga a janela de texto, escreve o mapa de nivel 2 e as respectivas mensagens,
;		apaga as strings Espera_0 e Espera_1, e inicializa as posicões do Pacman e Montros no campo JOGO_DIM

CallNivel2:	MOV	R1, 0001h
		MOV	M[Nivel_Actual], R1
		CALL	LimpaJT
		MOV	M[Pontos_Var], R0
		MOV	R2, Nivel2_L0
		CALL	EscMapa
		MOV	R1, 32h
		MOV	M[Nivel_?], R1
		CALL	EscTextoMapa
		CALL	LeCar
		CALL	ApagaEspera
		CALL	MONSTROS_INIC
		CALL	PACMAN_INICIO
		MOV	R1, 010Ah
		MOV	M[POSICAO_CUR], R1
		MOV	M[Pos], R1
		RET

;------------------------------------------------------------------------------

; CallNivel3: Rotina que apaga a janela de texto, escreve o mapa de nivel 3 e as respectivas mensagens,
;		apaga as strings Espera_0 e Espera_1, e inicializa as posicões do Pacman e Montros no campo JOGO_DIM

CallNivel3:	MOV	R1, 0010h
		MOV	M[Nivel_Actual], R1
		CALL	LimpaJT
		MOV	M[Pontos_Var], R0
		MOV	R2, Nivel3_L0
		CALL	EscMapa
		MOV	R1, 33h
		MOV	M[Nivel_?], R1
		CALL	EscTextoMapa
		CALL	LeCar
		CALL	ApagaEspera
		CALL	MONSTROS_INIC
		CALL	PACMAN_INICIO
		MOV	R1, 060Ah
		MOV	M[POSICAO_CUR], R1
		MOV	M[Pos], R1
		RET

;------------------------------------------------------------------------------

; Programa Principal: programa que permite jogar o jogo Pac-Man

Inicio:         MOV     R1, SP_INICIAL
                MOV     SP, R1					; Inicia valor do SP
		MOV     R1, INT_MASK
		MOV     M[INT_MASK_ADDR], R1
		MOV	R1, R0
TextoInicLoop:	MOV	M[DISP_0], R0
		MOV	M[DISP_1], R0				; Inicializa displays
		MOV	M[DISP_2], R0
		MOV	M[DISP_3], R0
		CALL	EscTextoInic
		CALL	LeCar
		CALL	ALAVANCAS_MAIN
		CALL	ActivaTempo
		ENI

Repete:		CALL	AcabaNivel
		MOV	R1, M[Interrupcao_Var]
		CMP	R1, 0001h				; Caso tenha ocorrido uma interrupção o salto ocorre
		BR.Z	Repete					; caso contrário, continua em loop
		CALL	IniDireccao
		MOV	R1, 0001h				; Volta a meter 1h na variável Interrupcao_Var para
		MOV	M[Interrupcao_Var], R1			; continuar à espera que ocorra uma interrupção
		BR	Repete

