class_name BigSlimeFootSteps extends Sprite2D

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
