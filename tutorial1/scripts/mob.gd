extends RigidBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	# the method in the tutorial wasnt working so had to modify to this
	var mob_types = anim.sprite_frames.get_animation_names()
	# takes a random value from the array of sprites and plays it
	anim.animation = mob_types.get(randi() % mob_types.size())
	anim.play()

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	queue_free()
