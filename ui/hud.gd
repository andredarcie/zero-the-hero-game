extends CanvasLayer

const HEART_ROW_SIZE: int = 8
const HEART_OFFSET: int = 8
var old_max_health

onready var tile_mini_map_texture = preload("res://ui/mini_map/tile_mini_map.png")
onready var important_mini_map_texture = preload("res://ui/mini_map/important_mini_map.png")
onready var player_mini_map_texture = preload("res://ui/mini_map/player_mini_map.png")
onready var tile_hide_mini_map_texture = preload("res://ui/mini_map/tile_hide_mini_map.png")

var mini_map_grid = []
var old_player_position_on_mini_map = Vector2(0, 0)

func _ready() -> void:
	add_to_group('Hud')
	old_max_health = GameState.player_max_health
	for i in GameState.player_max_health:
		add_new_heart()
	
	restart_mini_map()
	

func set_player_position_on_mini_map(position_x, position_y):
	
	mini_map_grid[old_player_position_on_mini_map.x][old_player_position_on_mini_map.y][2] = 0
	old_player_position_on_mini_map.x = position_x
	old_player_position_on_mini_map.y = position_y
	
	mini_map_grid[position_x][position_y][2] = 1
	draw_mini_map()
	
func set_place_discovered_on_mini_map(position_x, position_y):
	mini_map_grid[position_x][position_y][0] = 1
	draw_mini_map()
	
func set_important_place_on_mini_map():
	mini_map_grid[LevelManager.current_level_x][LevelManager.current_level_y][1] = 1
	draw_mini_map()

func destroy_mini_map():
	for child in $Base/MiniMap.get_children():
		$Base/MiniMap.remove_child(child)
		child.queue_free()
		
func restart_mini_map():
	for x in range(8):
		mini_map_grid.append([])
		mini_map_grid[x] = []
		for y in range(4):
			mini_map_grid[x].append([])
			mini_map_grid[x][y] = [0, 0, 0]
			
	old_player_position_on_mini_map.x = 4
	old_player_position_on_mini_map.y = 3
	mini_map_grid[4][3][2] = 1
	mini_map_grid[4][3][0] = 1
	
func draw_mini_map():		
	return
	
	var initial_position = 20
	
	destroy_mini_map()
	
	for x in range(8):
		for y in range(4):
			var tile_mini_map = Sprite.new()
			
			var layers = mini_map_grid[x][y]
			if layers[2] == 1:
				tile_mini_map.texture = player_mini_map_texture
			elif layers[1] == 1:
				tile_mini_map.texture = important_mini_map_texture
			elif layers[0] == 1:
				tile_mini_map.texture = tile_mini_map_texture
			else:
				tile_mini_map.texture = tile_hide_mini_map_texture
				
			tile_mini_map.global_position = Vector2(initial_position + x * 6, initial_position + y * 6)
			$Base/MiniMap.add_child(tile_mini_map)


func set_slot_icon(player, texture, animate):
	$Base/Slot/SlotIcon.texture = texture
	
	if not animate:
		return
		
	$Base/Slot/SlotIcon.global_position = player.global_position - Vector2(-80, 0)
	
	var _node = $Base/Slot/SlotIcon
	var _property = "global_position"
	var _initial_value = $Base/Slot/SlotIcon.global_position
	var _final_value = $Base/Slot.global_position
	var _duration = 0.2 # in seconds
	var _transition_type = Tween.TRANS_LINEAR
	var _ease_type = Tween.EASE_IN_OUT
	$Base/Tween.interpolate_property(
		_node,
		_property,
		_initial_value,
		_final_value,
		_duration,
		_transition_type,
		_ease_type
	)
	$Base/Tween.start()

func add_new_heart():
	var new_heart = Sprite.new()
	new_heart.texture = $Base/hearts.texture
	new_heart.hframes = $Base/hearts.hframes
	$Base/hearts.add_child(new_heart)
	
func hud_visible(flag):
	$Base/hearts.visible = flag
	$Base/VBoxContainer.visible = flag
	$Base/coin.visible = flag
	$Base/Slot.visible = flag
	$Base/MapTextLabel.visible = flag
	$Base/HopeTextLabel.visible = flag
	
	if OS.has_touchscreen_ui_hint():
		$Base/ActionTouchScreenButton.visible = true
		$Base/MobileJoystick.visible = true
		
	if flag:
		Hud.draw_mini_map()
	else:
		Hud.destroy_mini_map()
	
	
func _process(_delta: float) -> void:	
	if old_max_health != GameState.player_max_health:
		old_max_health = GameState.player_max_health
		add_new_heart()
		
	for heart in $Base/hearts.get_children():
		var index = heart.get_index()
		
		var x = (index % HEART_ROW_SIZE) * HEART_OFFSET
		var y = (index / HEART_ROW_SIZE) * HEART_OFFSET
		heart.position = Vector2(x, y)
		
		var last_heart = floor(GameState.player_health)
		if index > last_heart:
			heart.frame = 0
		if index == last_heart:
			heart.frame = (GameState.player_health - last_heart) * 4
		if index < last_heart:
			heart.frame = 4
			
			
	show_coins()
	
func show_coins():
	$Base/VBoxContainer/CoinTextLabel.text = " " + str(GameState.coins)

func _on_Tween_tween_completed(object, key):
	SoundEffects.play_get_item()
	$Base/AnimationPlayer.play("shake")


func _on_AnimationPlayer_animation_finished(anim_name):
	print(anim_name)
	if anim_name == "shake":
		$Base/AnimationPlayer.play("default")
