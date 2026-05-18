extends RigidBody2D

class_name Player

# Creating custom signal
signal game_started
signal died
signal scored

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var flap_sound: AudioStreamPlayer = $FlapSound
@onready var hit_sound: AudioStreamPlayer = $HitSound
@onready var score_sound: AudioStreamPlayer = $ScoreSound
@onready var game_start_sound: AudioStreamPlayer = $GameStartSound

var started = false
var flap_force = -340
var flap_angular_force = -8
var maximum_rotation_up = -30
var maximum_rotation_down = 90
var falling_velocity = 5
var is_alive := true

func _physics_process(delta: float) -> void:
	# check for player input
	if Input.is_action_just_pressed("flap") && is_alive:
		if !started:
			startGame()
		flap()
	
	# maximum rotation
	if rotation_degrees <= maximum_rotation_up:
		angular_velocity = 0
	
	# if the bird rotates more than 90 degrees stop rotating when falling down
	if linear_velocity.y > 0:
		if rotation_degrees <= maximum_rotation_down:
			angular_velocity = falling_velocity
		else:
			angular_velocity = 0

func flap():
	animation_player.play("flap")
	# - velocity to go up
	linear_velocity.y = flap_force
	angular_velocity = flap_angular_force
	flap_sound.play()

func startGame():
	started = true
	gravity_scale = 1
	game_started.emit()
	game_start_sound.play()

func die() -> void:
	if is_alive:
		is_alive = false
		died.emit()
		hit_sound.play()

func score_point() -> void:
	if is_alive:
		scored.emit()
		score_sound.play()
