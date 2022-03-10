extends Node2D

func _on_Area2D_body_entered(body):
	if GameState.check_body_is_player(body):
		
		if GameState.player_current_item_is_sword():
			LevelManager.current_player_position = GameState.player_current_dungeon_exit_position
			var scene_name = "res://levels/0-3.tscn"
			GameState.player_current_dungeon_level = 1
			var level = load(scene_name)

			if level != null:
				get_tree().change_scene_to(level)
			else:
				print("Failed to load the scene: ", scene_name)
		else:
			GameState.show_player_ballon_sword()
