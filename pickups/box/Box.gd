extends KinematicBody2D

var pushing = false

func _on_UpArea_body_entered(body):
	if not pushing:
		pushing = true
		global_position = global_position + Vector2(0, 16)
		$Timer.start()


func _on_Timer_timeout():
	$Timer.stop()
	pushing = false
	
