extends Node

var start_position_x: int = 0
var start_position_y: int = 0
var coins: int = 10
var keys: int = 0
var player_health: int = 3
var player_max_health: int = 3
var player_arrows: int = 10
var player_bombs: int = 2

enum SecondSlotItems {
	Bombs
	Arrow
}

var player_second_slot_item = SecondSlotItems.Bombs

func go_to_scene(x: int, y: int, name: String):
	start_position_x = x
	start_position_y = y
		
		
func set_player_start_position(player):
	player.global_position.x = start_position_x
	player.global_position.y = start_position_y


func get_current_scene_name() -> String:
	return get_tree().current_scene.name
	
	
func restart_game():
	get_tree().reload_current_scene()
	player_health = 3
	player_max_health = 3
	player_arrows = 10
	player_bombs = 2


func get_player():
	return get_tree().get_nodes_in_group('Player')[0]
	
	
func check_body_is_player(body) -> bool:
	return body.is_in_group("Player")
