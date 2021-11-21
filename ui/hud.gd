extends CanvasLayer

const HEART_ROW_SIZE: int = 8
const HEART_OFFSET: int = 8
var old_max_health
var sword_on_fire_texture: Texture = preload("res://items/sword_on_fire.png")
var sword_texture: Texture = preload("res://items/sword.png")

func _ready() -> void:
	add_to_group('Hud')
	old_max_health = GameState.player_max_health
	for i in GameState.player_max_health:
		add_new_heart()
		
	$Base/HeroIcon.position = Vector2(GameState.hero_icon_on_map_position_x, GameState.hero_icon_on_map_position_y)
		

func add_new_heart():
	var new_heart = Sprite.new()
	new_heart.texture = $Base/hearts.texture
	new_heart.hframes = $Base/hearts.hframes
	$Base/hearts.add_child(new_heart)
	
	
func _process(_delta: float) -> void:
	if GameState.player_sword_on_fire:
		$Base/Sword.texture = sword_on_fire_texture
	else:
		$Base/Sword.texture = sword_texture
	
	$Base/Items/WoodCountText.text = ' ' + str(GameState.player_wood)
	$Base/Items/MushroomCountText.text = ' ' + str(GameState.player_mushrooms)
		
	if Input.is_action_just_pressed("pause"):
		$Base/Items.visible = !$Base/Items.visible
		
		
	if Input.is_action_pressed("a"):
		$Base/SlotX.frame = 3
		$Base/SlotX/TimerSlotX.start()
		
	if Input.is_action_pressed("b"):
		if GameState.player_second_slot_item == GameState.SecondSlotItems.Bombs:
			if GameState.player_bombs == 0:
				$Base/bomb.visible = false
			else:
				$Base/bomb.visible = true
				
		$Base/SlotZ.frame = 1
		$Base/SlotZ/TimerSlotZ.start()
	
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
	show_keys()
	show_second_slot_item()
	
	


func show_coins():
	$Base/VBoxContainer/CoinTextLabel.text = " " + str(GameState.coins)
	
func show_keys():
	$Base/VBoxContainer/KeysTextLabel.text = " " + str(GameState.keys)
	
func show_second_slot_item():
	match (GameState.player_second_slot_item):
		GameState.SecondSlotItems.Arrow:
			$Base/VBoxContainer2/ArrowTextLabel.text = " arrows: " + str(GameState.player_arrows)
		GameState.SecondSlotItems.Bombs:
			$Base/VBoxContainer2/ArrowTextLabel.text = " Level: " + str(get_tree().get_root().get_child(3).name)
			
func get_item(name):
	$Base/AddItem/AddItemText.text = '+1 ' + str(name)
	
	$Base/AddItemAnimationPlayer.play('default')


func _on_TimerSlotZ_timeout():
	$Base/SlotZ.frame = 0


func _on_TimerSlotX_timeout():
	$Base/SlotX.frame = 2
	
func hide_menu():
	$Base/Items.visible = false
