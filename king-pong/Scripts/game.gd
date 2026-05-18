extends Node2D

@onready var ball: CharacterBody2D = $Ball
@onready var player: CharacterBody2D = $Player
@onready var bot: CharacterBody2D = $Bot
@onready var ball_timer: Timer = $BallTimer
@onready var player_score_label: Label = $Hud/PlayerScore
@onready var bot_score_label: Label = $Hud/BotScore

var mid_screen
var players_score := 0
var bots_score := 0

func _ready() -> void:
	mid_screen = get_viewport_rect().size.y / 2

func player_score(body):
	players_score += 1
	player_score_label.text = str(players_score)
	reset_paddles()

func bot_score(body):
	bots_score += 1
	bot_score_label.text = str(bots_score)
	reset_paddles()

func reset_paddles() -> void:
	player.set_position(Vector2(player.position.x, mid_screen))
	bot.set_position(Vector2(bot.position.x, mid_screen))
	ball_timer.start()

func new_game():
	reset_paddles()
	ball.ball_spawn()
	ball_timer.stop()

func game_over():
	pass
