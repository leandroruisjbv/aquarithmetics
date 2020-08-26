extends KinematicBody2D

signal game_over

export (float) var speed = 0.3 # Muito carinho com esse valor
export (int) var gravity = -1
var velocity = Vector2()
var not_stoped = true

func _physics_process(delta):
	if not_stoped :
		velocity = move_and_slide(velocity, Vector2.UP)
		velocity.y += speed * gravity * delta
		print(velocity.y)

func _on_Topo_body_entered(body):
	print("colidiu")
	not_stoped = false
	velocity.y = 0
	emit_signal("game_over")

func processa_sinais(sinal: String):
	if not_stoped :
		if sinal == ("acertou"):
			position.y = position.y + 20
			print("agua recebeu acerto")

		if sinal == ("errou"):
			velocity.y -= 1
			print("agua recebeu erro")


	
