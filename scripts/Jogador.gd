# Script Jogador
extends Node2D

signal resposta_certa
signal resposta_errada

var not_stoped = false
var delay := 0.0
var screen_size  # Size of the game window.
var text # Texto do Mostrador (display).
var placar = 0
var rng = RandomNumberGenerator.new()
var diff = 1
var resposta = "" # É a resposta que o usuário envia, podendo estar errada.
var resultado = 0 # É o resultado correto.
var ponto = 0 # Separador de decimais.
var question = "" # Pergunta a ser mostrada no visor.
var a = 0 # Lado esquerdo do operador.
var b = 0 # Lado direito do operador.
var op = '' # Operador da equação.

# _ready e _process(delta), nessa ordem, são funções "core" do jogo
func _ready():
	screen_size = get_viewport_rect().size
	stop()

func _process(delta):
	if !not_stoped : return
	if not delay > 0:
		if Input.is_key_pressed(KEY_MINUS) or Input.is_key_pressed(KEY_KP_SUBTRACT):
			if (resposta == '' or resposta.length() == 0):
				atualiza_display('-')
				
		elif Input.is_key_pressed(KEY_KP_0) or Input.is_key_pressed(KEY_0) :
			if resposta != '0':
				atualiza_display('0')  # Para não mostrar um 0 à esquerde de outro 0

			
		elif Input.is_key_pressed(KEY_1) or Input.is_key_pressed(KEY_KP_1):
			atualiza_display('1')
		elif Input.is_key_pressed(KEY_2) or Input.is_key_pressed(KEY_KP_2):
			atualiza_display('2')
		elif Input.is_key_pressed(KEY_3) or Input.is_key_pressed(KEY_KP_3):
			atualiza_display('3')
		elif Input.is_key_pressed(KEY_4) or Input.is_key_pressed(KEY_KP_4):
			atualiza_display('4')
		elif Input.is_key_pressed(KEY_5) or Input.is_key_pressed(KEY_KP_5):
			atualiza_display('5')
		elif Input.is_key_pressed(KEY_6) or Input.is_key_pressed(KEY_KP_6):
			atualiza_display('6')
		elif Input.is_key_pressed(KEY_7) or Input.is_key_pressed(KEY_KP_7):
			atualiza_display('7')
		elif Input.is_key_pressed(KEY_8) or Input.is_key_pressed(KEY_KP_8):
			atualiza_display('8')
		elif Input.is_key_pressed(KEY_9) or Input.is_key_pressed(KEY_KP_9):
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
		if resposta : testa_resultado()
		#testa_resultado()


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
		$CanvasLayer/Label.text = question + resposta

func gera_questao():
	op = gera_operador()
	if op == "÷" :
		print("divisaum")
		rng.randomize()
		resultado = rng.randi_range(1, 9)
		b = rng.randi_range(1, 9)
		a = resultado * b
			
	if op == "+" : # falta considerar os graus de dificuldade
		print("adição")
		if diff <= 3 : # Fácil (Não pode dar resultado negativo)
			rng.randomize()
			a = rng.randi_range(0, 9)
			b = rng.randi_range(0, 9)
			resultado = a + b

		else :
			rng.randomize()
			a = rng.randi_range(0, (diff * 10))
			b = rng.randi_range(0, (diff * 10))
			resultado = a + b
		
	if op == "-" :
		print("subtração")
		if diff <= 3 : # Fácil (Não pode dar resultado negativo)
			rng.randomize()
			resultado = rng.randi_range(0, 9)
			b = rng.randi_range(1, 9)
			a = resultado + b
						
		elif diff >= 5: # Hard (alcance ainda maior)
			rng.randomize()
			a = rng.randi_range(0, 99)
			b = rng.randi_range(0, 99)
			resultado = a - b

		else : # Médio (maior alcance e possibilidade de resultado negativo)
			rng.randomize()
			a = rng.randi_range(1, 99)
			b = rng.randi_range(0, 9)
			resultado = a - b

	
	if op == "x" : # falta considerar os graus de dificuldade
		print("multiplicação")
		rng.randomize()
		a = rng.randi_range(0, 9)
		b = rng.randi_range(0, 9)
		resultado = a * b
	
	var format_string = "%s %s %s = "
	question = format_string % [a, op, b]
	atualiza_display(question)
	pass

func gera_operador():
	var operador = 'a'
	var c = rng.randi_range(1, diff)

	if c == 1: operador = '+'
	if c == 2: operador = '+'
	if c == 3: operador = '-'
	if c == 4: operador = '-'
	if c == 5: operador = 'x'
	if c == 6: operador = 'x'
	if c == 7: operador = '÷'
	if c == 8: operador = '÷'
	if c == 9: operador = '÷'
	pass

	return operador

func insere_ponto():
	if ponto != 0 : return
	ponto += 1
	if resposta == '':
		atualiza_display('0.')
	else :
		atualiza_display('.')
		
func start(nivel: String) :
	if nivel == "easy" : diff = 1
	elif nivel == "medium" : diff = 4
	elif nivel == "hard" : diff = 7

	not_stoped = true
	placar = 0
	gera_questao()
	$CanvasLayer/Label.show()
	$CanvasLayer/Placar.text = "0000"
	$CanvasLayer/Placar.show()
	$CanvasLayer/Teclado.mostar_teclado()
	show()

func stop() :
	not_stoped = false
	# placar = 0
	# gera_questao()
	$CanvasLayer/Teclado.esconder_teclado()
	$CanvasLayer/Label.hide()
	$CanvasLayer/Placar.hide()
	hide()

func testa_resultado():
	var format_string = "%s"
	print(question + format_string % [resposta])
	print("resultado deu " + format_string % [resultado])
	
	if resposta.to_int() == resultado :
		emit_signal("resposta_certa")
		placar += 10
		$CanvasLayer/Placar.text = ("%04d" % [placar])
	else :
		emit_signal("resposta_errada")

	resposta = ""
	gera_questao()
	ponto = 0
	pass
	

func _on_Button1_pressed():
		atualiza_display('1')
		
func _on_Button2_pressed():
	atualiza_display('2')
	pass # Replace with function body.

func _on_Button3_pressed():
	atualiza_display('3')
	pass # Replace with function body.

func _on_Button4_pressed():
	atualiza_display('4')
	pass # Replace with function body.

func _on_Button5_pressed():
	atualiza_display('5')
	pass # Replace with function body.

func _on_Button6_pressed():
	atualiza_display('6')
	pass # Replace with function body.

func _on_Button7_pressed():
	atualiza_display('7')
	pass # Replace with function body.

func _on_Button8_pressed():
	atualiza_display('8')
	pass # Replace with function body.

func _on_Button9_pressed():
	atualiza_display('9')
	pass # Replace with function body.
	
func _on_Button0_pressed():
	if resposta != '0':
		atualiza_display('0')  # Para não mostrar um 0 à esquerde de outro 0


func _on_ButtonMinus_pressed():
	if (resposta == '' or resposta.length() == 0):
		atualiza_display('-')

func _on_ButtonDot_pressed():
	insere_ponto()

func _on_ButtonClear_pressed():
	resposta = ""
	atualiza_display(question)
	ponto = 0

func _on_ButtonSubmit_pressed():
	if resposta : testa_resultado()
