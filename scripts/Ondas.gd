extends KinematicBody2D

export (int) var speed = 200
#export (int) var speed = 120
#export (int) var jump_speed = -180
export (int) var gravity = -2

var velocity = Vector2()

#var velocity = Vector2.ZERO
var not_stoped = true

func _physics_process(delta):

	velocity = move_and_slide(velocity)
	velocity = move_and_slide(velocity, Vector2.UP)
	if not_stoped :
		velocity.y += gravity * delta
		print(velocity.y)

func _on_Topo_body_entered(body):
	print("entrou")
	not_stoped = false
	velocity.y = 0
	
func processa_sinais(sinal: String):
	if sinal == ("acertou"):
		velocity.y += 1
		print("agua recebeu acerto")

	if sinal == ("errou"):
		position.y = position.y + 200
		velocity.y -= 1
		print("agua recebeu erro")


	
