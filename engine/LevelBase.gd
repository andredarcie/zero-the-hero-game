extends Node2D

var player_scene = preload("res://player/Player/Player.tscn")

func _enter_tree():
	Hud.hud_visible(true)
		
	LevelManager.set_current_level_position()
	
	var player = player_scene.instantiate()
	player.global_position = LevelManager.current_player_position
	player.change_item(GameState.player_slot_item, false)
	
	if name.find("d") >= 0:
		player.turn_dark()
	else:
		player.turn_light()
		
	add_child(player)
