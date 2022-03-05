extends Area2D

export(String) var dungeon_name: String = ""
onready var DungeonScreen = preload("res://engine/Screens/DungeonScreen.tscn")

func _on_DungeonEntrance_body_entered(body):
	if GameState.check_body_is_player(body):
		GameState.player_current_dungeon_exit_position = $ExitPosition2D.global_position
		LevelManager.current_player_position = Vector2(32,32)
		GameState.player_current_dungeon_name = dungeon_name
		
		get_tree().change_scene_to(DungeonScreen)
