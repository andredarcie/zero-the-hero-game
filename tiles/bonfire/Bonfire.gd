extends Area2D

func _on_Bonfire_area_entered(area):
	catch_fire(area)
			
func catch_fire(body):
	if GameState.check_body_is_player(body.get_parent()):
		return
		
	var parent = body.get_parent()
		
	if parent.has_method("catch_fire"):
		parent.catch_fire()
