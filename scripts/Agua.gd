# Script Agua
extends Area2D

signal game_over

func _ready():
	hide()
	pass # Replace with function body.

func start():
	$Ondas.start()
	show()

func stop():
	$Ondas.stop()
	hide()

func _on_Jogador_resposta_certa():
	$Ondas.processa_sinais("acertou")
	pass # Replace with function body.

func _on_Jogador_resposta_errada():
	$Ondas.processa_sinais("errou")
	pass # Replace with function body.
	
func _on_Topo_body_entered(body):
	print("colidiu")
	emit_signal("game_over")
