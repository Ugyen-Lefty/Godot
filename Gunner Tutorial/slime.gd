extends CharacterBody2D

@export var mob_speed := 300
@export var smoke_scene : PackedScene

@onready var slime: Node2D = %Slime

var player
var health := 3

func _ready() -> void:
	slime.play_walk()

func _physics_process(delta: float) -> void:
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * mob_speed
	move_and_slide()

func take_damage() -> void:
	slime.play_hurt()
	health -= 1
	if health == 0:
		var smoke = smoke_scene.instantiate()
		queue_free()
		get_parent().add_child(smoke)
		smoke.global_position = global_position
		#add_child(sdmoke)
