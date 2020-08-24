extends Area2D

var delay := 0.0
var screen_size  # Size of the game window.
var text # Texto do Mostrador (display)
var rng = RandomNumberGenerator.new()
var diff = 2 # Dificuldade (de 1 à 3)
var resposta = "" # É a resposta que o usuário envia
var ponto = 0 # Separador de decimais
var question = "" # Pergunta
var a = 0
var b = 0
var op = ''

# _ready e _process(delta), nessa ordem, são funções "core" do jogo
func _ready():
	screen_size = get_viewport_rect().size	
	gera_questao()


func _process(delta):
	
	if not delay > 0:
		if Input.is_key_pressed(KEY_MINUS) or Input.is_key_pressed(KEY_KP_SUBTRACT):
			if (resposta == '' or resposta.length() == 0):
				print("apertou o minus")
				atualiza_display('-')
				
		elif Input.is_key_pressed(KEY_KP_0) or Input.is_key_pressed(KEY_0) :
			if resposta != '':
				atualiza_display('0')  # Para não mostrar um 0 à esquerde de outro 0
				
				
		elif Input.is_key_pressed(KEY_1) or Input.is_key_pressed(KEY_KP_1):
			atualiza_display('1')
		elif Input.is_key_pressed(KEY_2):
			atualiza_display('2')
		elif Input.is_key_pressed(KEY_3):
			atualiza_display('3')
		elif Input.is_key_pressed(KEY_4):
			atualiza_display('4')
		elif Input.is_key_pressed(KEY_5):
			atualiza_display('5')
		elif Input.is_key_pressed(KEY_6):
			atualiza_display('6')
		elif Input.is_key_pressed(KEY_7):
			atualiza_display('7')
		elif Input.is_key_pressed(KEY_8):
			atualiza_display('8')
		elif Input.is_key_pressed(KEY_9):
			atualiza_display('9')
			
		elif Input.is_key_pressed(KEY_PERIOD) or Input.is_key_pressed(KEY_KP_PERIOD):
			insere_ponto()
		elif Input.is_key_pressed(KEY_COMMA):
			insere_ponto()
			
		elif Input.is_key_pressed(KEY_BACKSPACE) and resposta.length() != 0:
			resposta = ""
			atualiza_display(question)
			ponto = 0
	else:
		delay -= delta
		
	if Input.is_action_just_pressed('ui_accept'):
		testa_resultado()
		
# As funções daqui pra baixo, são funções de apoio e devem estar em ordem afabética

func atualiza_display(text_str: String):
	var cont = resposta.length()
	if (resposta.left(1) == '-'):
		cont = resposta.length() - 1
		
	if text_str == '-' and (resposta.length() == 0 or resposta == ''):
		if question.right(question.length() - 1) != "=" :
			question = (question.substr(0, question.length() - 1))
			
	if  cont < 4 :
		delay = 0.13
		resposta += "" if text_str == question else text_str
		$Label.text = question + resposta
		
	print (resposta)

func gera_questao():
	rng.randomize()
	a = rng.randi_range(0, 9)
	b = rng.randi_range(0, 9)
	op = gera_operador()
	var format_string = "%s %s %s = "
	question = format_string % [a, op, b]
	atualiza_display(question)
	pass
	
func gera_operador():
	var operador = 'a'

	if diff == 3 : # Hard, difícil (chances iguais pra cada operação)
		var c = rng.randi_range(0, 3)
		if c == 0: operador = '+'
		if c == 1: operador = '-'
		if c == 2: operador = 'x'
		if c == 3: operador = '÷'
		
	if diff == 2 : # Nível médio (duas adições, duas subtrações e uma multiplicação)
		var c = rng.randi_range(0, 4)
		if c < 2: operador = '+'
		elif c == 4: operador = 'x'
		else : operador = '-'


	if diff == 1 : # Easy, fácil (três chances para adição e duas para subtração)
		var c = rng.randi_range(0, 4) 
		if c < 3: operador = '+'
		else : operador = '-'
	print (operador)
	return operador
	
func insere_ponto():
	if ponto != 0 : return
	ponto += 1
	if resposta == '':
		resposta += '0.'
		atualiza_display(resposta)
	else :
		resposta += '.'
		atualiza_display(text + '.')
		
	
func testa_resultado():
	resposta = ""
	gera_questao()
	ponto = 0
	pass
	
