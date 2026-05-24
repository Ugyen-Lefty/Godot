extends Area2D

@export var bullet_scene: PackedScene
@onready var shooting_point: Marker2D = %ShootingPoint

func _physics_process(delta: float) -> void:
	var enemies_in_range = get_overlapping_bodies()
	if enemies_in_range.size() > 0:
		# getting the frist value in the array
		var target_enemy = enemies_in_range.front()
		look_at(target_enemy.global_position)

func shoot() -> void:
	# instantiate is a pre built function to create a new instance of a node
	var bullet = bullet_scene.instantiate()
	# spawn the bullet at the shooting position marker
	bullet.global_position = shooting_point.global_position
	bullet.global_rotation = shooting_point.global_rotation
	# This is the same as dragging the bullet scene from the scenes folder to the 2D scene
	#shooting_point.add_child(bullet)
	add_child(bullet)
	#get_tree().root.add_child(bullet)


func _on_timer_timeout() -> void:
	shoot()
