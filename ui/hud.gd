class_name Hud extends CanvasLayer

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
		
	$HeroIcon.position = Vector2(GameState.hero_icon_on_map_position_x, GameState.hero_icon_on_map_position_y)
		

func add_new_heart():
	var new_heart = Sprite.new()
	new_heart.texture = $hearts.texture
	new_heart.hframes = $hearts.hframes
	$hearts.add_child(new_heart)
	
	
func _process(_delta: float) -> void:
	if GameState.player_sword_on_fire:
		$Sword.texture = sword_on_fire_texture
	else:
		$Sword.texture = sword_texture
	
	if Input.is_action_pressed("a"):
		$SlotX.frame = 3
		$SlotX/TimerSlotX.start()
		
	if Input.is_action_pressed("b"):
		if GameState.player_second_slot_item == GameState.SecondSlotItems.Bombs:
			if GameState.player_bombs == 0:
				$bomb.visible = false
			else:
				$bomb.visible = true
				
		$SlotZ.frame = 1
		$SlotZ/TimerSlotZ.start()
	
	if old_max_health != GameState.player_max_health:
		old_max_health = GameState.player_max_health
		add_new_heart()
		
	for heart in $hearts.get_children():
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
	$VBoxContainer/CoinTextLabel.text = " " + str(GameState.coins)
	
func show_keys():
	$VBoxContainer/KeysTextLabel.text = " " + str(GameState.keys)
	
func show_second_slot_item():
	match (GameState.player_second_slot_item):
		GameState.SecondSlotItems.Arrow:
			$VBoxContainer2/ArrowTextLabel.text = " arrows: " + str(GameState.player_arrows)
		GameState.SecondSlotItems.Bombs:
			$VBoxContainer2/ArrowTextLabel.text = " Level: " + str(get_tree().get_root().get_child(3).name)
			
func get_item(name):
	$AddItem/AddItemText.text = '+1 ' + str(name)
	
	$AddItemAnimationPlayer.play('default')


func _on_TimerSlotZ_timeout():
	$SlotZ.frame = 0


func _on_TimerSlotX_timeout():
	$SlotX.frame = 2
