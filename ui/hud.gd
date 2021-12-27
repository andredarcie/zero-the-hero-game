extends CanvasLayer

const HEART_ROW_SIZE: int = 8
const HEART_OFFSET: int = 8
var old_max_health

func _ready() -> void:
	add_to_group('Hud')
	old_max_health = GameState.player_max_health
	for i in GameState.player_max_health:
		add_new_heart()

func set_slot_icon(player, texture, animate):
	$Base/Slot/SlotIcon.texture = texture
	
	if not animate:
		return
		
	$Base/Slot/SlotIcon.global_position = player.global_position - Vector2(-80, 0)
	
	var _node = $Base/Slot/SlotIcon
	var _property = "global_position"
	var _initial_value = $Base/Slot/SlotIcon.global_position
	var _final_value = $Base/Slot.global_position
	var _duration = 0.5 # in seconds
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
	$Base/Map.visible = flag
	$Base/HeroIcon.visible = flag
	$Base/coin.visible = flag
	$Base/Slot.visible = flag
	
	if OS.has_touchscreen_ui_hint():
		$Base/UpTouchScreenButton.visible = true
		$Base/LeftTouchScreenButton.visible = true
		$Base/RightTouchScreenButton.visible = true
		$Base/DownTouchScreenButton.visible = true
		$Base/ActionTouchScreenButton.visible = true
	
	
func _process(_delta: float) -> void:
	$Base/HeroIcon.position = Vector2(GameState.hero_icon_on_map_position_x, GameState.hero_icon_on_map_position_y)
	
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


func _on_UpTouchScreenButton_pressed():
	print("teste")


func _on_LeftTouchScreenButton_pressed():
	pass # Replace with function body.


func _on_RightTouchScreenButton_pressed():
	pass # Replace with function body.


func _on_DownTouchScreenButton_pressed():
	pass # Replace with function body.


func _on_ActionTouchScreenButton_pressed():
	pass # Replace with function body.
