class_name Heart extends Pickup

func _ready():
	GameState.create(self)
	
func _on_heart_body_entered(body):
	if GameState.check_body_is_player(body):
		body.health += 1
		GameState.destroy(self)
		queue_free()
