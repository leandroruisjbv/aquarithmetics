# Script Agua
extends Area2D

signal game_over
signal certo
signal errado

func _ready():
	hide()
	pass # Replace with function body.

func start():
	$Ondas.start()
	show()

func stop():
	$Ondas.stop()
	yield(get_tree().create_timer(1), "timeout")
	hide()

func _on_Jogador_resposta_certa():
	$Ondas.processa_sinais("acertou")
	emit_signal("certo")

func _on_Jogador_resposta_errada():
	$Ondas.processa_sinais("errou")
	emit_signal("errado")
	
func _on_Topo_body_entered(body):
	print("colidiu")
	emit_signal("game_over")
