extends CanvasLayer

const HEART_ROW_SIZE: int = 8
const HEART_OFFSET: int = 8
var old_max_health

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

