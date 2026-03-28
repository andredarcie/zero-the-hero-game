extends Node2D

var current_level = 8
var current_player_position = Vector2(40,40)
var player_scene = preload("res://player/Player/Player.tscn")

func set_current_level_position():
	return

func _enter_tree():
	if LevelManager.current_level == 0:
		BackgroundMusic.play_main_sound()
		LevelManager.current_player_position = LevelManager.DEFAULT_PLAYER_POSITION
		Hud.draw_mini_map()
		Hud.set_player_position_on_mini_map(LevelManager.DEFAULT_MAP_POSITION.x, LevelManager.DEFAULT_MAP_POSITION.y)
		Hud.set_place_discovered_on_mini_map(LevelManager.DEFAULT_MAP_POSITION.x, LevelManager.DEFAULT_MAP_POSITION.y)

	Hud.hud_visible(true)

	LevelManager.set_current_level_position()
	
	var player = player_scene.instantiate()
	player.global_position = _resolve_player_spawn_position()
	player.change_item(GameState.player_slot_item, false)
	
	if name.find("d") >= 0:
		player.turn_dark()
	else:
		player.turn_light()
		
	add_child(player)


func _resolve_player_spawn_position() -> Vector2:
	var scene_level := -1
	if name.is_valid_int():
		scene_level = int(name)

	var spawn_position: Vector2 = LevelManager.current_player_position
	var spawn_marker := get_node_or_null("PlayerSpawn") as Node2D
	if spawn_marker == null:
		return spawn_position

	var scene_limits := _get_scene_limits()
	var stale_level_position := scene_level != -1 and LevelManager.current_level != scene_level
	var outside_limits := not scene_limits.has_point(spawn_position)
	if stale_level_position or outside_limits:
		return spawn_marker.global_position

	return spawn_position


func _get_scene_limits() -> Rect2:
	var width := 320.0
	var height := 240.0
	var camera := get_node_or_null("Player/camera") as Camera2D
	if camera != null:
		width = maxf(width, float(camera.limit_right))
		height = maxf(height, float(camera.limit_bottom))
	return Rect2(Vector2.ZERO, Vector2(width, height))
	
func go_to_next_level():
	current_player_position = Vector2(154,210)
	current_level = current_level + 1
	var scene_name = "res://levels/" + str(current_level) + ".tscn"
	SoundEffects.play_enter()
	change_scene_to_file(scene_name)

func change_scene_to_file(scene_name: String) -> void:	
	print("goto: ", scene_name)
	var level = load(scene_name)
	
	if level != null:
		get_tree().change_scene_to_packed(level)
	else:
		print("Failed to load the scene: ", scene_name)
