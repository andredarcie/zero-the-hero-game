extends Node2D

onready var DungeonScreen = preload("res://engine/Screens/DungeonScreen.tscn")

func _on_Area2D_body_entered(body):
	if GameState.check_body_is_player(body):
		GameState.player_current_dungeon_level = GameState.player_current_dungeon_level + 1
		get_tree().change_scene_to(DungeonScreen)
