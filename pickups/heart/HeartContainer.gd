extends Area2D

func _on_HeartContainer_body_entered(body):
	if GameState.check_body_is_player(body):
		if body.has_method("gain_max_health"):
			body.gain_max_health()
			queue_free()
