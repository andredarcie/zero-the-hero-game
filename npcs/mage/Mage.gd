class_name Mage extends Node2D

var dialogBox: DialogBox = null
var characterName = 'Mage'
var dialogs = ["You need to find the One Sword!!"]
var times = 0

func _ready():
	dialogBox = Hud.get_node("Base/DialogBox")

func _on_Area2D_body_entered(body):
	if not body.get('type') == "player":
		return
		
	Hud.get_node("Base/Items").visible = false
	dialogBox.start_dialog(self.characterName, self.dialogs)

func _on_Area2D_body_exited(body):
	if not GameState.check_body_is_player(body):
		return
	
	if dialogBox.is_dialog_ended():
		return
	
	if times > 0:
		times = times - 1
		
	dialogBox.end_dialog()
