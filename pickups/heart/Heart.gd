extends Area2D

func _ready():
	GameState.create(self)


func _on_Heart_body_entered(body):
	if GameState.check_body_is_player(body):
		if body.has_method("gain_health"):
			body.gain_health()
			GameState.destroy(self)
			SoundEffects.play_health_potion()
			queue_free()
