extends Sprite

var cut: bool = false

func _on_Area2D_area_entered(area):
	GameState.player_sword_cut_grass = true
	if area.get_parent().name == "sword" && GameState.player_sword_cut_grass:
		$StaticBody2D.queue_free()
		$Area2D.queue_free()
		$AnimatedSprite.speed_scale = 4
		$AnimatedSprite.play("cuting")
		cut = true


func _on_AnimatedSprite_animation_finished():
	if cut:
		$AnimatedSprite.queue_free()
		$Sprite.visible = true
		$AudioStreamPlayer2D.stream = preload("res://items/grass_cuting.wav")
		$AudioStreamPlayer2D.play()
