extends Area2D

@export var bullet_speed := 500
@export var bullet_range := 1500

var travelled_distance := 0

func _physics_process(delta: float) -> void:
	# Vector2.right is the same as Vector2(1,0)
	var direction = Vector2.RIGHT.rotated(rotation)
	# we are using delta here and not in move and slide in the player node becuase
	# the move and slide function automatically uses delta
	position += direction * bullet_speed * delta
	travelled_distance += bullet_speed * delta
	
	if travelled_distance > bullet_range:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
