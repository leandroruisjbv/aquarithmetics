# Script Game Over
extends CanvasLayer

signal start_easy
signal start_medium
signal start_hard
signal quit_game
signal close_app

signal about
signal instructions


# Called when the node enters the scene tree for the first time.
func _ready():
	apagar_luzes()
	pass # Replace with function body.

func show_message(text: String):
	$Mensagens.text = text
	$Mensagens.show()
	$MessageTimer.start()


func apagar_luzes():
	$Mensagens.hide()
	
	
	#$QuitGame.show()
	$Label.hide()
	
func acender_luzes():
	$Mensagens.show()
	$Easy.show()
	$Medium.show()
	$Hard.show()
	
	$About.show()
	$Instructions.show()
	
	$QuitGame.hide()
	$CloseApp.show()


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


func _on_Instructions_pressed():
	emit_signal("instructions")


func _on_About_pressed():
	emit_signal("about")


func _on_CloseApp_pressed():
	emit_signal("close_app")
	pass # Replace with function body.
