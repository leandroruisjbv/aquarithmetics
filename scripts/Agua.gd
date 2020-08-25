extends KinematicBody2D

export (int) var speed = 120
export (int) var jump_speed = -180
export (int) var gravity = 400

var velocity = Vector2.ZERO
var not_stoped = true

func get_input():
	velocity.x = 0
	if Input.is_action_pressed("walk_right"):
		velocity.x += speed
	if Input.is_action_pressed("walk_left"):
		velocity.x -= speed

func _physics_process(delta):
	get_input()
	# velocity.y += gravity * delta
	if not_stoped : velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = jump_speed


func _on_Topo_body_entered(body):
	print("entrou")
	not_stoped = false
	velocity.y = 0
	pass # Replace with function body.
