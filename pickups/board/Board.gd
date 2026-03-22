extends Area2D

@export var message = 'WORKING PROGRESS'
var dialogBox: DialogBox = null

func _on_Board_body_entered(body):
	if GameState.check_body_is_player(body):
		if dialogBox == null:
			dialogBox = Hud.get_node("Base/DialogBox") as DialogBox
			
		dialogBox.start_dialog("Board", [
			message
		])


func _on_Board_body_exited(body):
	if GameState.check_body_is_player(body):
		dialogBox.end_dialog()
