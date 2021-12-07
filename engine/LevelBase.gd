extends Node2D

var player_scene = preload("res://player/Player/Player.tscn")

func _enter_tree():
	if not Hud.get_child(0).visible:
		Hud.get_child(0).visible = true
		
	LevelManager.set_current_level_position()
	
	var player = player_scene.instance()
	player.global_position = LevelManager.current_player_position
	player.change_item(GameState.player_slot_item)
	
	if name.find("d") >= 0:
		player.turn_dark()
	else:
		player.turn_light()
		
	add_child(player)
