extends Area2D



func _on_DungeonEntrance_body_entered(body):
	if GameState.check_body_is_player(body):
		LevelManager.go_to_dungeon()
