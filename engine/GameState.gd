extends Node

var start_position_x: int = 0
var start_position_y: int = 0
var hero_icon_on_map_position_x: int = 14
var hero_icon_on_map_position_y: int = 11
var coins: int = 0
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
var player_cut_stone: bool = false

var dungeon_one_finished: bool = false

# Dungeons
var player_current_dungeon_level: int = 1
var player_current_dungeon_name: String = "first"
var player_current_dungeon_exit_position: Vector2 = Vector2(0, 0)

enum ItemSlot {
	Nothing,
	Sword,
	Bow,
	Bomb,
	Scythe,
	Axe,
	Key,
	Pickaxe,
	Wood,
	WoodOnFire,
	LavaBoots
}

var sword_texture = preload("res://items/sword_icon.png")
var bow_texture = preload("res://player/BowArrow/bow.png")
var bomb_texture = preload("res://items/bomb_icon.png")
var scythe_texture = preload("res://items/scythe_icon.png")
var axe_texture = preload("res://items/axe_icon.png")
var key_texture = preload("res://items/key_icon.png")
var pickaxe_texture = preload("res://items/pickaxe_icon.png")
var wood_texture = preload("res://items/wood_icon.png")
var wood_on_fire_texture = preload("res://items/wood_on_fire_icon.png")
var lava_boots_texture = preload("res://items/lava_boots_icon.png")

# d4-3
var d4_3_switch_1 = true

var persisted_objects = []

var unique_ids = {
		"first_boss": false
	}
		
	
func _ready() -> void:
	if DisplayServer.is_touchscreen_available():
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)

func go_to_scene(x: int, y: int, name: String):
	start_position_x = x
	start_position_y = y
		
		
func set_player_start_position(player):
	player.global_position.x = start_position_x
	player.global_position.y = start_position_y


func get_current_scene_name() -> String:
	return get_tree().current_scene.name
	
func change_player_item_to_wood():
	change_player_item(ItemSlot.Wood, false)
	
func change_player_item_to_wood_on_fire():
	change_player_item(ItemSlot.WoodOnFire, false)
	
func change_player_item(item, animate):
	GameState.player_slot_item = item
	var player = get_player()
	player.change_item(item, animate)
		
func destroy_item():
	var player = get_player()
	GameState.player_slot_item = 0
	player.change_item(GameState.player_slot_item, false)
	
func restart_game():
	Hud.restart_mini_map()
	Hud.hud_visible(false)
	#LevelManager.current_level_x = 4
	#LevelManager.current_level_y = 3
	#LevelManager.current_player_position = Vector2(248, 392)
	get_tree().call_group("Enemy", "queue_free")
	GameState.player_slot_item = 0
	persisted_objects = []
	player_arrows = 0
	player_bombs = 0
	player_wood = 0
	coins = 0
	number_of_player_deaths = number_of_player_deaths + 1
	
	if number_of_player_deaths >= 3:
		player_health = 4
		player_max_health = 4
	else:
		player_health = 3
		player_max_health = 3
		
	Hud.hud_visible(true)
	LevelManager.go_to_first_level()

func goto_title_screen():
	Hud.hud_visible(false)
	GameState.player_slot_item = 0
	player_health = 3
	player_max_health = 3
	persisted_objects = []
	BackgroundMusic.stop()
	LevelManager.change_scene_to_file("res://engine/Screens/TitleScreen.tscn")
	
	
func player_stop_moving():
	var player = get_player()
	player.player_cant_move = true
	
func show_player_ballon_scythe():
	var player = get_player()
	player.show_ballon_scythe()
	
func show_player_ballon_sword():
	var player = get_player()
	player.show_ballon_sword()
	
func show_player_ballon_axe():
	var player = get_player()
	player.show_ballon_axe()
	
func show_player_ballon_wood():
	var player = get_player()
	player.show_ballon_wood()
	
func show_player_ballon_key():
	var player = get_player()
	player.show_ballon_key()
	
func get_player():
	# return get_tree().get_nodes_in_group('Player')[0]
	return get_node("/root").find_child("Player", true, false)
	
func get_player_current_item():
	return player_slot_item
	
func player_current_item_is_wood():
	return player_slot_item == ItemSlot.Wood
	
func player_current_item_is_wood_on_fire():
	return player_slot_item == ItemSlot.WoodOnFire
	
func player_current_item_is_scythe():
	return player_slot_item == ItemSlot.Scythe
	
func player_current_item_is_sword():
	return player_slot_item == ItemSlot.Sword
	
func player_current_item_is_axe():
	return player_slot_item == ItemSlot.Axe

func player_current_item_is_key():
	return player_slot_item == ItemSlot.Key
	
func player_current_item_is_lava_boots():
	return player_slot_item == ItemSlot.LavaBoots
	
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
		ItemSlot.Pickaxe:
			texture = pickaxe_texture
		ItemSlot.Wood:
			texture = wood_texture
		ItemSlot.WoodOnFire:
			texture = wood_on_fire_texture
		ItemSlot.LavaBoots:
			texture = lava_boots_texture
			
	return texture
	
func get_hud():
	return get_node("/root").find_child("hud", true, false)
	
	
func check_body_is_player(body) -> bool:
	return body.is_in_group("Player")
	
	
func check_line_of_sight(npc, area, player) -> bool:
	player = get_player()
	var hitbox = player.get_node("hitbox")
	var space = npc.get_world_2d().direct_space_state
	
	var query := PhysicsRayQueryParameters2D.create(npc.global_position, hitbox.global_position, npc.collision_mask, [npc.get_rid(), area.get_rid()])
	query.collide_with_bodies = true
	query.collide_with_areas = true
	var LOS_obstacle: Dictionary = space.intersect_ray(query)
	
	if LOS_obstacle.is_empty():
		return false
	
	return LOS_obstacle.collider.name == "hitbox" or LOS_obstacle.collider.name == "sword"


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
			
	print(GameState.get_unique_name(object))
	persisted_objects.append({"unique_name" : GameState.get_unique_name(object),
							  "state": state })
							
							
func load_state(object) -> int:
	var unique_name = GameState.get_unique_name(object)
		
	for obj in persisted_objects:
		if obj["unique_name"] == unique_name:
			return obj["state"]
		
	return -1
