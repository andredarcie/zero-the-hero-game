extends Area2D

@onready var coin_sound: = preload("res://pickups/coin/coin.wav")

func _on_Coin_body_entered(body):
	if body.has_method("add_coin"):
		body.add_coin()
		SoundEffects.play_sound(coin_sound)
		queue_free()
