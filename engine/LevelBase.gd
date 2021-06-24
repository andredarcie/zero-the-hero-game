extends Node2D

var player_scene = preload("res://player/Player/Player.tscn")
var hud_scene = preload("res://ui/hud.tscn")

func _enter_tree():
	LevelManager.set_current_level_position()
	add_child(hud_scene.instance())
	var player = player_scene.instance()
	player.global_position = LevelManager.current_player_position
	add_child(player)
