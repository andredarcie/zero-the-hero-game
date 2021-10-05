extends Area2D

func _on_PoolOfBloodSpider_body_entered(body):
	if body.has_method("make_damage"):
		body.make_damage(self)

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
