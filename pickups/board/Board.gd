extends Area2D

export var message = ''
onready var dialogBox: DialogBox = get_node("../hud/DialogBox") as DialogBox

func _on_Board_body_entered(body):
	if body.get("type") == null:
		return 
		
	dialogBox.start_dialog("Board", [
		message
	])


func _on_Board_body_exited(body):
	dialogBox.end_dialog()
