extends Node2D

var dialogBox: DialogBox = null

func _ready():
	dialogBox = Hud.get_node("Base/DialogBox")
	dialogBox.start_dialog("Woman's Voice", [ 'Wake up zero' ])

func _input(event):
	if event.is_action_pressed("ui_accept"):
		dialogBox.end_dialog()
		BackgroundMusic.play_main_sound()
		LevelManager.current_player_position = Vector2(152, 168)
		LevelManager.change_scene("res://levels/4-3.tscn")

