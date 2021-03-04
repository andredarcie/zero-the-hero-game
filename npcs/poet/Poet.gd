class_name Poet extends Node2D

var dialogBox: DialogBox = null
var characterName = 'Poeta'
var dialogs = ["Tenho em mim todos os sonhos do mundo."]
var talkAboutTheKey = false

func _ready():
	dialogBox = get_tree().get_root().find_node("DialogBox", true, false) as DialogBox

func _on_Area2D_body_entered(body):
	if not GameState.check_body_is_player(body):
		return
		
	dialogBox.start_dialog(self.characterName, self.dialogs)

func _on_Area2D_body_exited(body):
	dialogBox.end_dialog()
