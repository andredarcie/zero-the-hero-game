extends Area2D

func _on_Area2D_body_entered(body):
	if GameState.check_body_is_player(body):
		GameState.get_item('Wood')
		queue_free()
		
