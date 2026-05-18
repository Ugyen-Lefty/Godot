extends Control

@onready var score_label: Label = $Panel/ScoreLabel
@onready var high_score_label: Label = $Panel/HighScoreLabel

# init_screen is a custom function not an in built one
func init_screen(score: int, high_score: int) -> void:
	score_label.text = "SCORE: " + str(score)
	high_score_label.text = "BEST: " + str(high_score)

func _on_retry_button_pressed() -> void:
	get_tree().reload_current_scene()

func show_gameover_scene() -> void:
	visible = true
