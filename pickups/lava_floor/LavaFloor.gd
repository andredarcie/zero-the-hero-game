extends Node2D

func _on_Area2D_body_entered(body):
	if GameState.check_body_is_player(body):
		if body.has_method("make_damage"):
			body.make_damage(self, false)
