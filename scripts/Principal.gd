# Script Principal
extends Node2D

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
	combo += combo
	$HUD.show_message("Certa resposta")
	yield(get_tree().create_timer(1), "timeout")
	$HUD/Mensagens.hide()

func _on_Agua_errado():
	$HUD.show_message("Não seja burro, besta!")
