extends Node

var start_position_x: int = 0
var start_position_y: int = 0
var hero_icon_on_map_position_x: int = 14
var hero_icon_on_map_position_y: int = 11
var coins: int = 0
var keys: int = 0
var menu_closed: bool = true

# Player
var player_health: int = 3
var player_max_health: int = 3

var player_arrows: int = 2
var player_bombs: int = 0
var player_sword_cut_grass: bool = false
var player_sword_cut_wood: bool = false
var player_mushrooms: int = 0
var player_wood: int = 0
var player_special_gloves_to_get_mushrooms: bool = false
var player_sword_on_fire: bool = false
var number_of_player_deaths: int = 0
var player_slot_item = 0
var player_have_key: bool = false

enum ItemSlot {
	Nothing,
	Sword,
	Bow,
	Bomb,
	Scythe,
	Axe,
	Key
}

var sword_texture = preload("res://items/sword_icon.png")
var bow_texture = preload("res://player/BowArrow/bow.png")
var bomb_texture = preload("res://items/bomb_icon.png")
var scythe_texture = preload("res://items/scythe_icon.png")
var axe_texture = preload("res://items/axe_icon.png")
var key_texture = preload("res://items/key_icon.png")

# d4-3
var d4_3_switch_1 = true

var persisted_objects = []

var unique_ids = {
		"first_boss": false
	}
		
	
func go_to_scene(x: int, y: int, name: String):
	start_position_x = x
	start_position_y = y
		
		
func set_player_start_position(player):
	player.global_position.x = start_position_x
	player.global_position.y = start_position_y


func get_current_scene_name() -> String:
	return get_tree().current_scene.name
	
	
func restart_game():
	Hud.hud_visible(false)
	LevelManager.current_player_position = Vector2(248, 392)
	get_tree().call_group("Enemy", "queue_free")
	GameState.player_slot_item = 0
	persisted_objects = []
	player_arrows = 0
	player_bombs = 0
	player_wood = 0
	keys = 0
	coins = 0
	number_of_player_deaths = number_of_player_deaths + 1
	
	if number_of_player_deaths >= 3:
		player_health = 4
		player_max_health = 4
	else:
		player_health = 3
		player_max_health = 3
		
	
	LevelManager.change_scene("res://engine/Screens/EndScreen.tscn")


func get_player():
	# return get_tree().get_nodes_in_group('Player')[0]
	return get_node("/root").find_node("Player", true, false)
	
func get_item_texture(item):
	var texture = null
	
	match item:
		ItemSlot.Nothing:
			texture = null
		ItemSlot.Sword:
			texture = sword_texture
		ItemSlot.Bow:
			texture = bow_texture
		ItemSlot.Bomb:
			texture = bomb_texture
		ItemSlot.Scythe:
			texture = scythe_texture
		ItemSlot.Axe:
			texture = axe_texture
		ItemSlot.Key:
			texture = key_texture
			
	return texture
	
func get_hud():
	return get_node("/root").find_node("hud", true, false)
	
	
func check_body_is_player(body) -> bool:
	return body.is_in_group("Player")
	
	
func check_line_of_sight(npc, area, player) -> bool:
	player = get_player()
	var hitbox = player.get_node("hitbox")
	
	var space = npc.get_world_2d().direct_space_state
	var LOS_obstacle = space.intersect_ray(npc.global_position, hitbox.global_position, [npc, area], npc.collision_mask, true, true)
	
	if not LOS_obstacle:
		return false
	
	return LOS_obstacle.collider.name == "hitbox"


func activate_id(unique_id):
	if unique_id != "":
		unique_ids[unique_id] = true
		
	print(unique_ids)
		
		
func check_id(unique_id: String) -> bool:
	if unique_id != "":
		return unique_ids[unique_id]
	else:
		return false
		
func get_item(name):
	#var hud = get_hud()
	#hud.get_item(name)
	
	if name == 'Mushroom':
		player_mushrooms = player_mushrooms + 1
	if name == 'Wood':
		player_wood = player_wood + 1
		
func get_unique_name(object):
	var level_name = "scene:"+ get_tree().get_current_scene().get_name() + "--"
	var position = "x-" + str(object.global_position.x) + "-y-" + str(object.global_position.y)  + "--"
	
	return level_name + position + object.name
	
func create(object):
	var unique_name = GameState.get_unique_name(object)
	
	if GameState.persisted_objects.has(unique_name):
		object.queue_free()
		
func create_check(object) -> bool:
	var unique_name = GameState.get_unique_name(object)
	
	for obj in persisted_objects:
		if obj["unique_name"] == unique_name:
			return true
		
	return false

func destroy(object):
	persisted_objects.append({"unique_name" : GameState.get_unique_name(object),
							  "state": 0 })
	
func save_state(object, state):
	var unique_name = GameState.get_unique_name(object)
	
	for obj in persisted_objects:
		if obj["unique_name"] == unique_name:
			obj["state"] = state
			return
			
	persisted_objects.append({"unique_name" : GameState.get_unique_name(object),
							  "state": state })
							
							
func load_state(object) -> int:
	var unique_name = GameState.get_unique_name(object)
		
	for obj in persisted_objects:
		if obj["unique_name"] == unique_name:
			return obj["state"]
		
	return -1
