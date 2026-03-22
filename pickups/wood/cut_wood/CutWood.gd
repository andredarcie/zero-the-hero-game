extends Area2D

@onready var get_item_sound : AudioStream = preload("res://pickups/item/get_item.wav")	

func _on_Area2D_body_entered(body):
	if GameState.check_body_is_player(body):
		GameState.get_item('Wood')
		SoundEffects.play_sound(get_item_sound)
		queue_free()
		
