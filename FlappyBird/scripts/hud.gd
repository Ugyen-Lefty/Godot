extends CanvasLayer

@onready var score_label: Label = $ScoreLabel
@onready var start_message: TextureRect = $StartMessage
@onready var game_over_screen: Control = $GameOverScreen

func set_score(new_score: int) -> void:
	# we're setting the labels value to the new_score argument
	# then were converting that value into string
	score_label.text = str(new_score)

func hide_start_message() -> void:
	start_message.visible = false

func show_game_over(score: int, high_score: int) -> void:
	game_over_screen.init_screen(score, high_score)
	game_over_screen.show_gameover_scene()
