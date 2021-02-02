extends Node2D

var player_scene = preload("res://player/player.tscn")
var hud_scene = preload("res://ui/hud.tscn")

func _enter_tree():
	add_child(hud_scene.instance())
	var player = player_scene.instance()
	player.global_position = LevelManager.current_player_position
	add_child(player)
