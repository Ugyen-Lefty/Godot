extends Node2D

# mob scene is the slime scene
@export var mob_scene: PackedScene

@onready var path_follow_2d: PathFollow2D = %PathFollow2D
@onready var player: CharacterBody2D = %Player
@onready var game_over: CanvasLayer = %GameOver

func spawn_mob() -> void:
	var new_mob: Node2D = mob_scene.instantiate()
	path_follow_2d.progress_ratio = randf()
	new_mob.global_position = path_follow_2d.global_position
	add_child(new_mob)
	# this is to pass the refernece to the slime scene about the player
	# since the slime is spawned dynamically it does not have the reference to player node.
	# but if i pass it from the game script which always has access to all nodes it will work.
	new_mob.player = player

func _on_mob_spawn_timer_timeout() -> void:
	spawn_mob()

func _on_player_health_depleted() -> void:
	game_over.visible = true
	get_tree().paused = true

func _on_button_pressed() -> void:
	get_tree().paused = false
	game_over.visible = false
	get_tree().reload_current_scene()
