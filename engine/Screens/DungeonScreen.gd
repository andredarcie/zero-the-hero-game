extends Control

func _ready():
	Hud.hud_visible(false)
	$TextBox.text = "Level 1-" + str(GameState.player_current_dungeon_level)

func _on_Timer_timeout():
	var scene_name = "res://levels/dungeons/" + str(GameState.player_current_dungeon_name) + "/" + str(GameState.player_current_dungeon_level) + ".tscn"
	var level = load(scene_name)

	if level != null:
		Hud.hud_visible(true)
		get_tree().change_scene_to_packed(level)
	else:
		print("Failed to load the scene: ", scene_name)
