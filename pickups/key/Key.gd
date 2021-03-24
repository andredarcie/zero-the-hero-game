class_name Key extends Pickup

func _on_Key_body_entered(body):
	if GameState.check_body_is_player(body) && GameState.keys < 9:
		$AnimationPlayer.play("get")


func _on_AnimationPlayer_animation_finished(anim_name):
	GameState.keys += 1
	queue_free()
