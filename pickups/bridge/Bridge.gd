extends Node2D

func _process(delta):
	if GameState.player_wood >= 2:
		$Area2D/Sprite.modulate.a = 255

func _on_Area2D_body_entered(body):
	if GameState.check_body_is_player(body):
		if GameState.player_wood >= 2:
			GameState.player_wood = GameState.player_wood - 2
		
			$Area2D.queue_free()
			$BridgeArea2D/Sprite.visible = true
			for _i in $BridgeArea2D.get_overlapping_bodies():
				var staticBody2D = _i.get_parent().get_node("StaticBody2D")
				if staticBody2D:
					staticBody2D.queue_free()
					
			SoundEffects.play_bridge_sound()
		else:
			var player = GameState.get_player()
			player.show_ballon_wood()
		


func _on_Area2D_body_exited(body):
	if GameState.check_body_is_player(body):
		var player = GameState.get_player()
		player.hide_ballon_wood()
