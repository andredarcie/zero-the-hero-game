extends Node

const FIRST_LEVEL_PATH := "res://levels/1.tscn"
const LAST_LEVEL := 10
const DEFAULT_PLAYER_POSITION := Vector2(152, 168)
const NEXT_LEVEL_PLAYER_POSITION := Vector2(154, 210)
const DEFAULT_MAP_POSITION := Vector2i(4, 3)

var current_level: int = 0
var current_level_x: int = DEFAULT_MAP_POSITION.x
var current_level_y: int = DEFAULT_MAP_POSITION.y
var current_player_position: Vector2 = DEFAULT_PLAYER_POSITION


func set_current_level_position() -> void:
	var current_scene := get_tree().current_scene
	if current_scene == null:
		return

	var scene_name := str(current_scene.name)
	if scene_name.is_valid_int():
		current_level = int(scene_name)

	# The original minimap layout was lost with the old level manager.
	# Keep a safe default until the real overworld mapping is restored.
	current_level_x = DEFAULT_MAP_POSITION.x
	current_level_y = DEFAULT_MAP_POSITION.y


func go_to_first_level(start_position: Vector2 = DEFAULT_PLAYER_POSITION) -> void:
	current_level = 1
	current_player_position = start_position
	current_level_x = DEFAULT_MAP_POSITION.x
	current_level_y = DEFAULT_MAP_POSITION.y
	_reset_player_item_for_level_start()
	change_scene_to_file(FIRST_LEVEL_PATH)


func go_to_next_level() -> void:
	var next_level := current_level + 1

	if next_level > LAST_LEVEL:
		change_scene_to_file("res://engine/Screens/EndScreen.tscn")
		return

	current_level = next_level
	current_player_position = NEXT_LEVEL_PLAYER_POSITION
	_reset_player_item_for_level_start()
	SoundEffects.play_enter()
	change_scene_to_file("res://levels/" + str(current_level) + ".tscn")


func go_to_land() -> void:
	current_player_position = GameState.player_current_dungeon_exit_position
	change_scene_to_file("res://levels/" + str(max(current_level, 1)) + ".tscn")


func change_scene_to_file(scene_name: String) -> void:
	print("goto: ", scene_name)
	var level := load(scene_name)

	if level != null:
		get_tree().change_scene_to_packed(level)
	else:
		print("Failed to load the scene: ", scene_name)


func _reset_player_item_for_level_start() -> void:
	GameState.player_slot_item = GameState.ItemSlot.Nothing
