extends CanvasLayer

var cor = [Color.red, Color.green, Color.blue, Color.yellow]
var rng = RandomNumberGenerator.new()
var rand

func _ready():
	for _debugNode in get_tree().get_nodes_in_group("Teclado"):
		_debugNode.hide()

func mostar_teclado():
	for _debugNode in get_tree().get_nodes_in_group("Teclado"):
		_debugNode.show()
		rng.randomize()
		var rand = rng.randi_range(0, 3)
		_debugNode.add_color_override("font_color", cor[rand])

func esconder_teclado():
	for _debugNode in get_tree().get_nodes_in_group("Teclado"):
		_debugNode.hide()

