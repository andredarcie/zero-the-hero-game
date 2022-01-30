extends Node2D

func _on_Area2D_body_entered(body):
	if GameState.check_body_is_player(body) and not GameState.player_current_item_is_lava_boots():
		if body.has_method("make_damage"):
			body.make_damage(self, false, false)
