extends Area2D

func _on_DungeonExit_body_entered(body):
	if GameState.check_body_is_player(body):
		LevelManager.go_to_land()
