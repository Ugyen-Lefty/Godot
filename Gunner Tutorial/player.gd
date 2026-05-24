extends CharacterBody2D

signal health_depleted

# making this variable being able to access from the inspector
@export var movement_speed := 600
@export var damage_rate := 5

# this referencing can break if the node youre referencing's path is changed so its reccommended to use %
@onready var happy_boo: Node2D = $HappyBoo
@onready var hurt_box: Area2D = %HurtBox
@onready var health_bar: ProgressBar = %HealthBar



var health := 100.0

func _physics_process(delta: float) -> void:
	var direction = Input.get_vector("move_left","move_right","move_up","move_down")
	velocity = direction * movement_speed
	move_and_slide()

	if velocity.length() > 0:
		# the % is used to access unique nodes
		# but first have to enable the option to access as unique name
		%HappyBoo.play_walk_animation()
	else:
		%HappyBoo.play_idle_animation()
	
	var overlapping_mobs = hurt_box.get_overlapping_bodies()
	if overlapping_mobs.size() > 0.0:
		health -= damage_rate * overlapping_mobs.size() * delta
		health_bar.value = health
		if health <= 0.0:
			health_depleted.emit()
	
