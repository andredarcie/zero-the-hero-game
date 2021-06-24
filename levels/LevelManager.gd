extends Node

const LEVEL_MAX_SIZE_X = 32 * 16
const LEVEL_MAX_SIZE_Y = 32 * 16
var current_level_x = 0
var current_level_y = 0
var number_of_levels_in_x = 8
var number_of_levels_in_y = 8
var current_player_position = Vector2(16,16)

func _ready():
	set_current_level_position()
	

func set_current_level_position():
	var scene_name = GameState.get_current_scene_name()
	
	if scene_name == 'TitleScreen':
		return
		
	var level = scene_name.split("-")
	current_level_x = int(level[0])
	current_level_y = int(level[1])
	

func check_current_level(move_direction: Vector2, player_position: Vector2):		
	if current_level_x != 0 and move_direction == Vector2.LEFT and player_position.x < 0:
		go_to_next_level(move_direction, player_position)
	if current_level_x != number_of_levels_in_x and move_direction == Vector2.RIGHT and player_position.x > LEVEL_MAX_SIZE_X:
		go_to_next_level(move_direction, player_position)
	if current_level_y != 0 and move_direction == Vector2.UP and player_position.y < 0:
		go_to_next_level(move_direction, player_position)
	if current_level_y != number_of_levels_in_y and move_direction == Vector2.DOWN and player_position.y > LEVEL_MAX_SIZE_Y:
		go_to_next_level(move_direction, player_position)
	

func go_to_next_level(move_direction: Vector2, player_position: Vector2):
	match move_direction:
		Vector2.UP:
			current_player_position = Vector2(player_position.x, LEVEL_MAX_SIZE_Y)
			current_level_y -= 1
		Vector2.DOWN:
			current_player_position = Vector2(player_position.x, 0)
			current_level_y += 1
		Vector2.LEFT:
			current_player_position = Vector2(LEVEL_MAX_SIZE_X, player_position.y)
			current_level_x -= 1
		Vector2.RIGHT:
			current_player_position = Vector2(0, player_position.y)
			current_level_x += 1
		
		
	if current_level_x < 0:
		current_level_x = 0
	
	if current_level_x > LEVEL_MAX_SIZE_X:
		current_level_x = LEVEL_MAX_SIZE_X
		
	if current_level_y < 0:
		current_level_y = 0
	
	if current_level_y > LEVEL_MAX_SIZE_Y:
		current_level_y = LEVEL_MAX_SIZE_Y
		
	var scene_name = "res://levels/" + str(current_level_x) + "-" + str(current_level_y) + ".tscn"
	change_scene(scene_name)
		
		
func go_to_dungeon() -> void:
	current_player_position = GameState.get_player().global_position
	
	var scene_name = "res://levels/d" + str(current_level_x) + "-" + str(current_level_y) + ".tscn"
	change_scene(scene_name)
		
		
func go_to_land() -> void:
	current_player_position = GameState.get_player().global_position
	
	var scene_name = "res://levels/" + str(current_level_x) + "-" + str(current_level_y) + ".tscn"
	change_scene(scene_name)
	
		
func change_scene(scene_name: String) -> void:
	print("goto: ", scene_name)
	var level = load(scene_name)
	
	if level != null:
		get_tree().change_scene_to(level)
	else:
		print("Failed to load the scene: ", scene_name)
