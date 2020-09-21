# Script Game Over
extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	apagar_luzes()
	pass # Replace with function body.

func show_message(text: String):
	$Score.text = text
	$Score.show()
	$MessageTimer.start()

func apagar_luzes():
	for _debugNode in get_tree().get_nodes_in_group("GameOver"):
		_debugNode.hide()

func acender_luzes(score: String):
	for _debugNode in get_tree().get_nodes_in_group("GameOver"):
		_debugNode.show()
		
		show_message(score)

