extends Node

var current_level = 6
var current_player_position = Vector2(40,40)

func set_current_level_position():
	return
	
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
