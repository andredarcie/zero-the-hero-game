extends Sprite
	
func _on_Area2D_area_entered(area):
	if area.get_parent().name == "sword":
		$StaticBody2D.queue_free()
		$Area2D.queue_free()
		$AnimatedSprite.queue_free()
		$Sprite.visible = true
