extends Control

func _input(event):
	if event.is_action_pressed("ui_accept"):
		LevelManager.current_player_position = Vector2(248, 392)
		LevelManager.change_scene("res://levels/4-3.tscn")
