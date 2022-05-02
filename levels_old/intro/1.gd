extends Node2D

var player_scene = preload("res://player/Player/Player.tscn")

func _enter_tree():
	Hud.hud_visible(false)
	
	var player = player_scene.instance()
	player.global_position = Vector2(160,208)
	player.change_item(GameState.player_slot_item, false)
	player.turn_light()
	add_child(player)


func _on_Exit_body_entered(body):
	if GameState.check_body_is_player(body):
		var level = load("res://levels/intro/2.tscn")
		get_tree().change_scene_to(level)
