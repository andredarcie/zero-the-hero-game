extends Area2D

export(String) var dungeon_name: String = ""

func _on_DungeonEntrance_body_entered(body):
	if GameState.check_body_is_player(body):
		GameState.player_current_dungeon_exit_position = $ExitPosition2D.global_position
		var scene_name = "res://levels/dungeons/" + dungeon_name + "/" + str(GameState.player_current_dungeon_level) + ".tscn"
		LevelManager.current_player_position = Vector2(32,32)
		GameState.player_current_dungeon_name = dungeon_name
		var level = load(scene_name)
	
		if level != null:
			get_tree().change_scene_to(level)
		else:
			print("Failed to load the scene: ", scene_name)
			
		SoundEffects.play_enter()
		BackgroundMusic.play_dungeon_sound()
