extends Node2D

var player_scene = preload("res://player/Player/Player.tscn")

func _enter_tree():
	Hud.hud_visible(true)
	
	var player = player_scene.instance()
	player.global_position = Vector2(40,40)
	player.change_item(GameState.player_slot_item, false)
	
	if name.find("d") >= 0:
		player.turn_dark()
	else:
		player.turn_light()
		
	add_child(player)
