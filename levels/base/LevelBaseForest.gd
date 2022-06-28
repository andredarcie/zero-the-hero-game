extends Node2D

var current_level = 8
var current_player_position = Vector2(40,40)
var player_scene = preload("res://player/Player/Player.tscn")

func set_current_level_position():
	return

func _enter_tree():
	Hud.hud_visible(true)
		
	LevelManager.set_current_level_position()
	
	var player = player_scene.instance()
	player.global_position = LevelManager.current_player_position
	player.change_item(GameState.player_slot_item, false)
	
	if name.find("d") >= 0:
		player.turn_dark()
	else:
		player.turn_light()
		
	add_child(player)
	
func go_to_next_level():
	current_player_position = Vector2(154,210)
	current_level = current_level + 1
	var scene_name = "res://levels/" + str(current_level) + ".tscn"
	SoundEffects.play_enter()
	change_scene(scene_name)

func change_scene(scene_name: String) -> void:	
	print("goto: ", scene_name)
	var level = load(scene_name)
	
	if level != null:
		get_tree().change_scene_to(level)
	else:
		print("Failed to load the scene: ", scene_name)
