extends StaticBody2D

func _ready():
	GameState.create(self)
	
func _on_area_body_entered(body):
	if GameState.check_body_is_player(body) && GameState.keys > 0:
		GameState.keys -= 1
		GameState.destroy(self)
		queue_free()
