extends Area2D

func _on_Bonfire_area_entered(area):
	if area.name == "sword":
		if GameState.player_current_item_is_wood():
			var parent = area.get_node("../../../")
			if parent.has_method("catch_fire"):
				parent.catch_fire()
		else:
			GameState.show_player_ballon_wood()
