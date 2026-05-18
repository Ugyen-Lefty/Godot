extends Node2D

@onready var obstacle_spawner: Node2D = $ObstacleSpawner
# in order to access the animation within the ground node, you have to first create a reference to it inside the ground node
# then access the animation node from the ground
@onready var ground: StaticBody2D = $Ground
@onready var hud: CanvasLayer = $HUD

var score := 0
var high_score := 0
# this is to save the high score in the user file system
# we can use user:// to access the file system in any OS
var save_file_path := "user://flappy_bird_highscore.dat"

func _ready() -> void:
    get_high_score()
    hud.set_score(score)

func _on_player_game_started() -> void:
    obstacle_spawner.start()
    hud.hide_start_message()

func _on_player_died() -> void:
    # this is the function that is within the obstacle_spawner game node
    ground.animation_player.pause()
    obstacle_spawner.stop()
    # this will call a function from every scene that belongs to a certain group
    get_tree().call_group("obstacles", "stop")
    # this waits for 0.5 seconds then proceeds with the function
    await get_tree().create_timer(0.5).timeout
    
    # setting high score logic
    if score > high_score:
        high_score = score
        save_high_score()
        
    hud.show_game_over(score, high_score)

func _on_player_scored() -> void:
    score += 1
    hud.set_score(score)

func save_high_score() -> void:
    # this opens the file or creates one if it does not exist
    var save_data = FileAccess.open(save_file_path, FileAccess.WRITE)
    save_data.store_var(high_score)
    save_data.close()

func get_high_score() -> void:
    # checking whether the save file exists
    if FileAccess.file_exists(save_file_path):
        var load_data = FileAccess.open(save_file_path, FileAccess.READ)
        high_score = load_data.get_var()
