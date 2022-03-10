extends Node2D

var player_scene = preload("res://player/Player/Player.tscn")

func _ready():
	var player = player_scene.instance()
	player.global_position = Vector2(160,208)
	player.change_item(GameState.player_slot_item, false)
	player.turn_light()
	add_child(player)
