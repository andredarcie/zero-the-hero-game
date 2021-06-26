extends Sprite

var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	frame = rng.randi_range(0, 1)
	print(frame)


func _on_Area2D_body_entered(body):
	if GameState.check_body_is_player(body):
		frame = 2
