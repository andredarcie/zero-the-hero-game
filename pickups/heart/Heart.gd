extends Area2D


func _ready():
	pass


func _on_Heart_body_entered(body):
	if GameState.check_body_is_player(body):
		if body.has_method("gain_health"):
			body.gain_health()
			queue_free()
