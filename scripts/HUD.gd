# Script HUD
extends CanvasLayer

signal start_easy
signal start_medium
signal start_hard
signal quit_game


# Called when the node enters the scene tree for the first time.
func _ready():
	$QuitGame.hide()
	pass # Replace with function body.

func show_message(text: String):
	$Mensagens.text = text
	$Mensagens.show()
	$MessageTimer.start()


func apagar_luzes():
	$Mensagens.hide()
	$Easy.hide()
	$Medium.hide()
	$Hard.hide()
	
	$About.hide()
	$Instructions.hide()
	
	$QuitGame.show()
	
func acender_luzes():
	$Mensagens.show()
	$Easy.show()
	$Medium.show()
	$Hard.show()
	
	$About.show()
	$Instructions.show()
	
	$QuitGame.hide()


func _on_Easy_pressed():
	emit_signal("start_easy")
	apagar_luzes()
	
func _on_Medium_pressed():
	emit_signal("start_medium")
	apagar_luzes()

func _on_Hard_pressed():
	emit_signal("start_hard")
	apagar_luzes()

func _on_QuitGame_pressed():
	emit_signal("quit_game")
