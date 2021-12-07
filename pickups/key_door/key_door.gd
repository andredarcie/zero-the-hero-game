extends StaticBody2D

func _ready():
	GameState.create(self)
	
func _on_area_body_entered(body):
	if GameState.check_body_is_player(body) && GameState.player_have_key:
		GameState.player_have_key = false
		GameState.player_slot_item = 0
		var player = GameState.get_player()
		player.remove_item()
		GameState.destroy(self)
		queue_free()
