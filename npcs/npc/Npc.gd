class_name Npc extends Node2D

var dialogBox: DialogBox = null
var characterName: String = 'Death'
var dialogs = ["Nihilist knight! Do you accept a game of chess for your soul?"]

func _ready():
	dialogBox = get_tree().get_root().find_node("DialogBox", true, false) as DialogBox

func _on_Area2D_body_entered(body):
	if not GameState.check_body_is_player(body):
		return
		
	dialogBox.start_dialog(self.characterName, self.dialogs)

func _on_Area2D_body_exited(body):
	dialogBox.end_dialog()
