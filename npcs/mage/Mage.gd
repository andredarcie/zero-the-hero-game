class_name Mage extends Node2D

var dialogBox: DialogBox = null
var characterName = 'Mage'
var dialogs = ["You arrived too early my dear Zero! The gods haven't finished building this world yet...",
			   "In the beginning there was only Zero but then One was created ",
			   " and so it was possible to represent anything in the cosmos",
			   "You need to find the One Sword again otherwise everything will be meaningless!",
			   "It's dangerous to go alone! Take this spell to cut bushes with your sword!"]
			
var times = 0

func _ready():
	dialogBox = get_tree().get_root().find_node("DialogBox", true, false) as DialogBox

func _on_Area2D_body_entered(body):
	if not body.get('type') == "player":
		return
		
	if self.times == 1:
		times = times + 1
		dialogBox.start_dialog(self.characterName, [
			'Give up!',
			"Everything I told you is a lie, you're just a character in a game posted on itch.io"
		])
		return
		
	if self.times == 2:
		times = times + 1
		dialogBox.start_dialog(self.characterName, [
			'...'
		])
		return
		
	if self.times == 3:
		times = times + 1
		dialogBox.start_dialog(self.characterName, [
			"Shut down your computer now, it's an order!"
		])
		return
		
	if self.times == 4:
		dialogBox.start_dialog(self.characterName, [
			"..."
		])
		return
		
	dialogBox.start_dialog(self.characterName, self.dialogs)
	GameState.player_sword_cut_grass = true
	times = times + 1

func _on_Area2D_body_exited(body):
	dialogBox.end_dialog()
