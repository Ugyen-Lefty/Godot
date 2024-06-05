extends Area2D

@onready var game_manager = %GameManager
@onready var pick_up = $PickUp
@onready var collision_shape_2d = $CollisionShape2D

func _on_body_entered(body):
	visible = false
	collision_shape_2d.disabled = true
	print(collision_shape_2d.name)
	game_manager.add_point()
	body.get_node("CollisionShape2D").disabled = true

func _on_body_exited(body):
	pick_up.play()
	collision_shape_2d.disabled = true

func _on_pick_up_finished():
	queue_free()
