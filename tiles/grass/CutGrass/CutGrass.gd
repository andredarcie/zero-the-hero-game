extends Sprite2D

var cut: bool = false

func _ready():
	if GameState.create_check(self):
		$StaticBody2D.queue_free()
		$Area2D.queue_free()
		$AnimatedSprite2D.queue_free()
		$Sprite2D.visible = true
		
		
func _on_Area2D_area_entered(area):
	if area.name == "sword":
		if GameState.player_current_item_is_scythe():
			$StaticBody2D.queue_free()
			$Area2D.queue_free()
			$AnimatedSprite2D.speed_scale = 4
			$AnimatedSprite2D.play("cuting")
			cut = true
			GameState.destroy(self)
		else:
			GameState.show_player_ballon_scythe()

func _on_AnimatedSprite_animation_finished():
	if cut:
		$AnimatedSprite2D.queue_free()
		$Sprite2D.visible = true
		$AudioStreamPlayer2D.stream = preload("res://items/grass_cuting.wav")
		$AudioStreamPlayer2D.play()
