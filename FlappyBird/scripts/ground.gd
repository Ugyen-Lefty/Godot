extends StaticBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_death_zone_body_entered(body: Node2D) -> void:
	# can do both, one is playing with groups made on the top right next to signals
	# making a group called damageable and assigning the player
	# and the other is assigning the player to a class_name Player
	#if body.is_in_group("damageable"):
	if body is Player:
		body.die()
