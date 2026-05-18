extends CharacterBody2D

var speed := -215.0

func _on_pipe_body_entered(body: Node2D):
	if body is Player:
		# you can call the childs function directly from the body var
		body.die()

func _on_score_area_body_entered(body: Node2D) -> void:
	if body is Player:
		body.score_point()

func _physics_process(delta: float) -> void:
	velocity.x = speed
	
	# to delete the pipe once its outta view
	if global_position.x < -10:
		queue_free()
	move_and_slide()

func stop() -> void:
	speed = 0
