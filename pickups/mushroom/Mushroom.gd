extends Sprite

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	frame = rng.randi_range(0, 1)


func _on_Area2D_body_entered(body):
	if frame == 2:
		return
		
	if GameState.check_body_is_player(body):
		frame = 2
		$AudioStreamPlayer2D.stream = preload("res://pickups/mushroom/cut.wav")
		$AudioStreamPlayer2D.play()
		GameState.get_item('Mushroom')
