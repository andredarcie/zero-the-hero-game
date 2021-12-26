extends Node2D

func _on_Area2D_body_entered(body):
	if GameState.check_body_is_player(body):
		GameState.player_current_dungeon_level = GameState.player_current_dungeon_level + 1
		var scene_name = "res://levels/dungeons/" + str(GameState.player_current_dungeon_name) + "/" + str(GameState.player_current_dungeon_level) + ".tscn"
		var level = load(scene_name)
	
		if level != null:
			get_tree().change_scene_to(level)
		else:
			print("Failed to load the scene: ", scene_name)
