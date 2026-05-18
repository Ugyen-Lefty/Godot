extends CharacterBody2D

@onready var ball: CharacterBody2D = $"../Ball"

@export var speed := 300

func _physics_process(delta: float) -> void:
	var dist = ball.position.y - position.y   # Distance (ball above = positive, below = negative)
	
	if ball.velocity.x > 0:
		if abs(dist) > speed * delta:
			# Move at capped speed in the right direction
			velocity.y = speed * sign(dist)
		else:
			# Close enough: move exactly the remaining distance
			velocity.y = dist / delta
	else:
		velocity.y = 0

	move_and_slide()
