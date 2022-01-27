extends StaticBody2D

func _ready():
	if GameState.create_check(self):
		queue_free()
	

func _on_area_area_entered(area):
	if area.name == "sword":
		if GameState.player_current_item_is_key():
			GameState.destroy(self)
			GameState.destroy_item()
			queue_free()
		else:
			GameState.show_player_ballon_key()
