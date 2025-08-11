extends Area2D

signal hit

@export var speed = 400 #how fast the player will move
var player_size
var game_start: bool = false
#@export var screen_size = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_size = $CollisionShape2D.shape.get_rect().size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# Enable movement only when game starts if you want that feature
	#game_start and move_player(delta)
	move_player(delta)

func move_player(delta: float):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	
	#This is so that the character does not move faster diagonally
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	# To keep the player within the screen
	var view_port := get_viewport_rect()
	position += velocity * delta
	#position = position.clamp(Vector2.ZERO, Vector2(view_port.size.x, view_port.size.y))
	position = position.clamp(Vector2.ZERO + player_size/2, Vector2(view_port.size.x, view_port.size.y)-player_size/2)
	
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
	$AnimatedSprite2D.flip_v = velocity.y > 0
	
	#if velocity.x != 0:
		#$AnimatedSprite2D.animation = "walk"
		#$AnimatedSprite2D.flip_h = velocity.x < 0
	#elif velocity.y != 0:
		#$AnimatedSprite2D.animation = "up"
	
	#if velocity != 0:
		#$AnimatedSprite2D.flip_v = velocity.y > 0

func _on_body_entered(e) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true)

#func start(pos):
func start():
	#position = pos
	show()
	$CollisionShape2D.disabled = false

func _on_hud_start_game() -> void:
	game_start = true
