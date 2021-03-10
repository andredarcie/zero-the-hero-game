class_name Npc extends Node2D

var dialogBox: DialogBox = null
var characterName: String = 'Morte'
var dialogs = ["Cavaleiro niilista! Aceita uma partida de xadrez por sua alma?"]

func _ready():
	dialogBox = get_tree().get_root().find_node("DialogBox", true, false) as DialogBox

func _on_Area2D_body_entered(body):
	if not GameState.check_body_is_player(body):
		return
		
	dialogBox.start_dialog(self.characterName, self.dialogs)

func _on_Area2D_body_exited(body):
	dialogBox.end_dialog()
