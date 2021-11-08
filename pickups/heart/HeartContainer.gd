extends Area2D

func _ready():
	if GameState.create_check(self):
		self.queue_free()
		
func _on_HeartContainer_body_entered(body):
	if GameState.check_body_is_player(body):
		if body.has_method("gain_max_health"):
			body.gain_max_health()
			GameState.destroy(self)
			queue_free()
