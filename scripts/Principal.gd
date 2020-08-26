# Script Principal
extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func new_game(nivel: String):
	$Jogador.start(nivel)
	$Agua.start()

func game_over():
	$Jogador.stop()
	$Agua.stop()
	pass


func _on_HUD_start_easy():
	new_game("easy")

func _on_HUD_start_hard():
	new_game("hard")

func _on_HUD_start_medium():
	new_game("medium")
