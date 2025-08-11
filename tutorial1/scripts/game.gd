extends Node2D

@export var mob_scene: PackedScene

@onready var mob_timer: Timer = $MobTimer
@onready var score_timer: Timer = $ScoreTimer
@onready var mob_spawn_point: PathFollow2D = $MobPath/MobSpawnPoint
@onready var hud: CanvasLayer = $HUD
@onready var death_sound: AudioStreamPlayer2D = $DeathSound
@onready var player: Area2D = $Player
@onready var start_timer: Timer = $StartTimer
@onready var start_position: Marker2D = $StartPosition

var score: int = 0

func game_over() -> void:
	death_sound.play()
	score_timer.stop()
	mob_timer.stop()
	hud.show_game_over()
	get_tree().call_group("mobs", "queue_free")

func new_game():
	player.set_position(start_position.position)
	player.start()
	start_timer.start()
	hud.update_score(score)
	hud.show_message("Ready...")

func _on_mob_timer_timeout() -> void:
	# create a new instance of mob scene
	var mob = mob_scene.instantiate()
	# chooses a random location in path2D
	mob_spawn_point.progress_ratio = randf()

	# setting the mobs position to the random points position
	# mob.position = mob_spawn_point.position
	# Here i first used local position instead of global position that was making the mobs
	# spawn from outside the Path2D node
	mob.position = mob_spawn_point.global_position
	
	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_point.rotation + PI / 2
	# adding randomness to direction
	#direction += randf_range(-PI / 4, PI / 4)
	direction += randf()
	mob.rotation = direction
	
	# adding movement for the mobs
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	#spawning the mob by adding it to the main scene
	add_child(mob)

# Change this logic to when killing enemies in the future
func _on_score_timer_timeout() -> void:
	score += 1
	hud.update_score(score)

func _on_start_timer_timeout() -> void:
	mob_timer.start()
	score_timer.start()

func _on_player_hit() -> void:
	# handle player death logic here
	game_over()
