# Script Principal
extends Node2D

var rng = RandomNumberGenerator.new()
var combo = 0
var erros = 0

func _process(delta):
	$Agua.diff = $Jogador.diff
	$Agua.set_background()
	pass

func _ready():
	pass # Replace with function body.

func new_game(nivel: String):
	combo = 0
	erros = 0
	$Jogador.start(nivel)
	$Agua.start()

func game_over():
	$Jogador.stop()
	$Agua.stop()
	$HUD.show_message("Game Over")
	$StartTimer.start()
	yield($StartTimer, "timeout")
	var placar = ("%04d" % [$Jogador.placar])
	
	$GameOver.acender_luzes(placar)
	pass
	
func close_app():
	get_tree().quit()
	pass
	
func quit_game():
	$Jogador.stop()
	$Agua.stop()
	$HUD/Mensagens.text = "Aquarithmetics"
	$HUD/Mensagens.show()
	$GameOver.apagar_luzes()
	$HUD.acender_luzes()
	#close_app()
	


func _on_HUD_start_easy():
	new_game("easy")

func _on_HUD_start_hard():
	new_game("hard")

func _on_HUD_start_medium():
	new_game("medium")

func _on_HUD_quit_game():
	quit_game()
	 

func _on_Agua_certo():
	combo += 1
	erros = 0
	if $Jogador.placar > 0 :
		if (combo % 7 == 0) or ($Jogador.placar % 140 == 0):
			$Jogador.diff += 1
			$Agua/Ondas.start()

	$HUD.show_message(motiva(true))
	yield(get_tree().create_timer(1), "timeout")
	$HUD/Mensagens.hide()


func _on_Agua_errado():
	erros += 1
	combo = 0
	if erros > 0 :
		if (erros % 3 == 0):
			$Jogador.diff -= 1
	
	var cor = get_node("HUD/Mensagens").get_color("font_color")
	get_node("HUD/Mensagens").add_color_override("font_color", Color.red)

	$HUD.show_message(motiva(false))
	yield(get_tree().create_timer(1), "timeout")
	$HUD/Mensagens.hide()
	get_node("HUD/Mensagens").add_color_override("font_color", cor)

func motiva(acertou : bool):
	var fraco = rng.randi_range(0, 3) # Mero feedback.
	var regular = rng.randi_range(3, 6) # Um certo desdém...
	var genio = rng.randi_range(6, 9) # Um belo elogio!
	
	var errada = rng.randi_range(0, 2) # Um belo elogio!
	
	print(combo)
	var vetor_erro = [0,1,2]
	vetor_erro[0] = "Ops! Não foi dessa vez..."
	vetor_erro[1] = "Não desista, tente de novo"
	vetor_erro[2] = "Ah, que peninha. Continue tentando"
	
	var array = ["Acertou!", "Isso ;)", "Certinho", "Correto", 4, 5, 6, 7, 8, 9]
	array[4] = "Olha, acertou de novo!"
	array[5] = "Muito bom! :p"
	array[6] = "E o placar tá aumentando..."
	array[7] = "Incrível, acertou mais uma!"
	array[8] = "Ah, mulék!!!"
	array[9] = "Genial!!!"
	var msg = ""
	
	if !acertou :
		msg = vetor_erro[errada]
	else : # Combos do lol
		if combo < 3 : msg = "%s" % array[fraco]
		elif combo > 6 : msg = "%s" % array[genio]
		else : msg = "%s" % array[regular]
	
	return msg
	pass


func _on_Crditos_voltar():
	$HUD.acender_luzes()
	pass # Replace with function body.

func _on_Instrues_voltar():
	$HUD.acender_luzes()
	pass # Replace with function body.


func _on_HUD_about():
	$"Creditos".mostrar_creditos()
	$HUD.apagar_luzes()
	$HUD/QuitGame.hide()
	pass # Replace with function body.


func _on_HUD_instructions():
	$"Instrucoes".mostrar_instrucoes()
	$HUD.apagar_luzes()
	$HUD/QuitGame.hide()
	pass # Replace with function body.


func _on_HUD_close_app():
	close_app()
	pass # Replace with function body.
