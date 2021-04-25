extends Sprite

func _on_Area2D_area_entered(area):
	if area.get_parent().name == "sword":
		frame = 1
		$StaticBody2D.queue_free()
		$Area2D.queue_free()
