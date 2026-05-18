extends CharacterBody2D

@export var speed: int = 300

func _physics_process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	#if Input.is_action_pressed("move_left"):
		#velocity.x -= 1
	#if Input.is_action_pressed("move_right"):
		#velocity.x += 1

	# Apparently this is the most popular way to handle diagonal faster movement issue
	#if velocity != Vector2.ZERO:
		#velocity = velocity.normalized() * speed
	position += velocity * speed * delta
	
	# Without move and slide it does not detect collisions on char body2D
	# TODO: revisit once better at gdscript
	#move_and_collide(velocity * delta)
	move_and_slide()
