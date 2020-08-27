# Script Principal
extends Node2D

var rng = RandomNumberGenerator.new()
var combo = 0

func _ready():
	pass # Replace with function body.

func new_game(nivel: String):
	combo = 0
	$Jogador.start(nivel)
	$Agua.start()

func game_over():
	$Jogador.stop()
	$Agua.stop()
	$HUD.show_message("Game Over")
	$StartTimer.start()
	yield($StartTimer, "timeout")
	$HUD/Mensagens.text = "Aquarithmetics"
	$HUD/Mensagens.show()
	yield(get_tree().create_timer(1), "timeout")
	$HUD.acender_luzes()
	pass
	
func quit_game():
	$Jogador.stop()
	$Agua.stop()
	$HUD/Mensagens.text = "Aquarithmetics"
	$HUD/Mensagens.show()
	$HUD.acender_luzes()
	
func certo_errado(txt: String):
	pass



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
	$HUD.show_message(ofensa(false))
	yield(get_tree().create_timer(1), "timeout")
	$HUD/Mensagens.hide()

func _on_Agua_errado():
	combo = 0
	$HUD.show_message(ofensa(true))
	yield(get_tree().create_timer(1), "timeout")
	$HUD/Mensagens.hide()

func ofensa(errou : bool):
	var fraco = rng.randi_range(0, 3) # Mero feedback.
	var regular = rng.randi_range(3, 6) # Um certo desdém...
	var genio = rng.randi_range(6, 9) # Um belo elogio!
	
	print(combo)
	var array = ["Acertou!", "Isso", "Certinho", "correto", 4, 5, 6, 7, 8, 9]
	array[4] = "Ah, acertou de novo?!"
	array[5] = "Ui, acertante :p"
	array[6] = "E o placar tá aumentando..."
	array[7] = "Impossível, acertou mais uma!"
	array[8] = "Ah, mulék!!!"
	array[9] = "Genial!!!"
	var msg = ""
	
	if errou : msg = "Não seja burro, besta!"
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
	$"Créditos".mostrar_creditos()
	$HUD.apagar_luzes()
	$HUD/QuitGame.hide()
	pass # Replace with function body.


func _on_HUD_instructions():
	$"Instruções".mostrar_instrucoes()
	$HUD.apagar_luzes()
	$HUD/QuitGame.hide()
	pass # Replace with function body.
