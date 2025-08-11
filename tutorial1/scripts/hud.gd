extends CanvasLayer

signal start_game

@onready var message: Label = $Message
@onready var message_timer: Timer = $MessageTimer
@onready var start_button: Button = $StartButton
@onready var score_label: Label = $ScoreLabel

@export var title: String

func show_message(text: String):
	message.text = text
	message.show()
	message_timer.start()

func show_game_over():
	show_message("Game Over")
	# wait till the message timer has counted down
	await message_timer.timeout
	
	message.text = title
	message.show()
	# apparently this code is the official way similar to settimeout in js
	await get_tree().create_timer(1.0).timeout
	start_button.show()

func update_score(score: int):
	score_label.text = str(score)

func _on_start_button_pressed() -> void:
	start_button.hide()
	start_game.emit()

func _on_message_timer_timeout() -> void:
	message.hide()
