extends KinematicBody2D

signal game_over

export (int) var gravity = -1
var velocity = Vector2()
var not_stoped = true

func _physics_process(delta):
	if not_stoped :
		velocity = move_and_slide(velocity, Vector2.UP)
		velocity.y += gravity * delta
		print(velocity.y)

func _on_Topo_body_entered(body):
	print("colidiu")
	not_stoped = false
	velocity.y = 0
	emit_signal("game_over")
	
func processa_sinais(sinal: String):
	if not_stoped :
		if sinal == ("acertou"):
			velocity.y += 1
			print("agua recebeu acerto")
	
		if sinal == ("errou"):
			position.y = position.y + 20
			velocity.y -= 1
			print("agua recebeu erro")


	
