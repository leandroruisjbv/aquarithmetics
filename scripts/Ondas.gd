# Script Ondas

extends KinematicBody2D

signal colidiu

export (float) var speed = 0.3 # Muito carinho com esse valor
export (int) var gravity = -1
var velocity = Vector2()
var not_stoped = false

func start():
	velocity = Vector2()
	velocity.y = 0.0
	not_stoped = true
	position.y = 700

func stop():
	not_stoped = false
	velocity.y = 0

func _physics_process(delta):
	if not_stoped :
		velocity = move_and_slide(velocity, Vector2.UP)
		velocity.y += speed * gravity * delta
		#print(velocity.y)


func processa_sinais(sinal: String):
	if not_stoped :
		if sinal == ("acertou"):
			position.y = position.y + 20
			print("agua recebeu acerto")

		if sinal == ("errou"):
			velocity.y -= 1
			print("agua recebeu erro")


	
