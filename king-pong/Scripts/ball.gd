extends CharacterBody2D

@onready var game: Node = $".."

@export var speed: int = 300;
@export var speed_multiplier: int = 50;

var start_pos

func _ready():
	start_pos = get_viewport_rect().size / 2
	ball_spawn()

# The = in the argument is to make it optional
func ball_spawn(_pos: Vector2 = Vector2(0,0)):
	#if _pos:
	position = start_pos
	# Pick one of the 2 speeds where as for the y we pick in a range between the speeds
	velocity = Vector2([speed, -speed].pick_random(), randf_range(-speed, speed))

func _physics_process(delta):
	var col := move_and_collide(velocity * delta)
	if col:
		# gives the exact angle of the surface so the ball reflects realistically
		# Normal gives the angle when colliding
		if velocity.x < 0:
			velocity.x -= speed_multiplier
		else:
			velocity.x += speed_multiplier
		velocity = velocity.bounce(col.get_normal())
	
	
