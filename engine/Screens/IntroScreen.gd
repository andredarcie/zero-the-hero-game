extends Node2D

var dialogBox: DialogBox = null
var times = 0

func _ready():
	dialogBox = Hud.get_node("Base/DialogBox")
	dialogBox.connect("dialogue_ended", self, "_on_dialogue_ended")

func _on_dialogue_ended():
	if times == 0:
		dialogBox.start_dialog("Woman's Voice", [ 'You have to become [color=#1f92ef]One[/color].'])
		times = times + 1
	elif times == 1:
		BackgroundMusic.play_main_sound()
		LevelManager.current_player_position = Vector2(152, 168)
		LevelManager.change_scene("res://levels/4-3.tscn")

func _on_Timer_timeout():
	dialogBox.start_dialog("Woman's Voice", [ 'Wake up [color=#495057]Zero[/color]!'])
