# Script Instruções
extends CanvasLayer
signal voltar



func _ready():
	$RichTextLabel.hide()
	$Button.hide()
	pass # Replace with function body.

func mostrar_instrucoes():
	$RichTextLabel.show()
	$Button.show()
	pass # Replace with function body.


func _on_Button_pressed():
	emit_signal("voltar")
	$RichTextLabel.hide()
	$Button.hide()
	pass # Replace with function body.
