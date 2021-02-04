extends Node2D

var state: bool = false

func _on_Area2D_body_entered(body):
	state = true
	set_state()


func set_state():
	state = !state
	if state:
		$Sprite.frame = 0
	else:
		$Sprite.frame = 1
		
	
	for child in self.get_children():
		if child.get("active") != null:
			child.active = !state


func _on_Area2D_body_exited(body):
	state = false
	set_state()
