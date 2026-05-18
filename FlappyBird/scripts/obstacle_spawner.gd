extends Node2D

@onready var spawn_timer: Timer = $SpawnTimer

# loading the obstacle scene into this variable
var obstacle_scene: PackedScene = preload("res://scenes/obstacle.tscn")

func start() -> void:
	spawn_timer.start()

func stop() -> void:
	spawn_timer.stop()

func _on_spawn_timer_timeout() -> void:
	var obstacle = obstacle_scene.instantiate()
	var max_y = 119.0
	var min_y = -192.0
	add_child(obstacle)
	# this is local in the context of the parent, if want to change global position have 
	# to change global_position
	# We instantiate the obstacle into the spawner first in the 2D view to find the exact values for the range
	# Then randomize the range between those values so it can spawn in between
	obstacle.position.y = randf_range(max_y, min_y)
