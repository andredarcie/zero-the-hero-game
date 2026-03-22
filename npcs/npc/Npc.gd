class_name Npc extends Node2D

var dialogBox: DialogBox = null
var faceSprite = null
var characterName: String = ''
var dialogs = ["Nihilist knight! Do you accept a game of chess for your soul?"]

@onready var death_texture = preload("res://npcs/death/death.png")
@onready var wizard_texture = preload("res://npcs/mage/mage.png")


enum NPCS { Cat, Wizard, Poet, Astronaut, Death, Businessman, Workman, Artist }
@export var npc: NPCS = NPCS.Cat

func _ready():
	dialogBox = Hud.get_node("Base/DialogBox")
	dialogBox.connect("dialogue_ended", Callable(self, "_on_dialogue_ended"))
	faceSprite = dialogBox.get_node("FaceSprite")
	
	match (npc):
		NPCS.Cat:
			characterName = 'Cat'
			$Sprite2D.frame = 0
			faceSprite.texture 
			dialogs = ["You must be the hero who seeks to find the sword?",
					   "Yes. I am a talking cat",
					   "And you're a naked primate in an armor",
					   "Well the game is still in the Alpha version, so I think it's impossible for you to find the sword"]
		NPCS.Wizard:
			characterName = 'Wizard'
			$Sprite2D.hframes = 1
			$Sprite2D.vframes = 1
			$Sprite2D.frame = 0
			$Sprite2D.texture = wizard_texture
			dialogs = ["You need to find the One sword! Be careful!"]
		NPCS.Poet:
			characterName = 'Poet'
			$Sprite2D.frame = 1
			dialogs = ["Maybe one day I can get back to writing poems",
					   "You know that writing poems doesn't make any money",
					   "You can make money being a hero?"]
		NPCS.Astronaut:
			characterName = 'Astrounat'
			$Sprite2D.frame = 2
			dialogs = ["My ship crashes in this place, I'm trying to find its parts",
					   "But I think they landed on a part of the map that isn't available in the alpha version."]
		NPCS.Death:
			characterName = 'Death'
			$Sprite2D.hframes = 1
			$Sprite2D.vframes = 1
			$Sprite2D.frame = 0
			$Sprite2D.texture = death_texture
			dialogs = ["Nihilist knight! Do you accept a game of chess for your soul?",
					   "You died but you haven't reached the end of your journey",
					   "Thanks for playing the Alpha version of the game!",
					   "Submit your feedback"]
		NPCS.Businessman:
			characterName = 'Businessman'
			$Sprite2D.frame = 3
			dialogs = ["Work hard and you'll find the sword you're looking for"]
		NPCS.Workman:
			characterName = 'Workman'
			$Sprite2D.frame = 4
			dialogs = ["I used an ax to cut uranium, but you can cut other things with it"]
		NPCS.Artist:
			characterName = 'Artist'
			$Sprite2D.frame = 5
			dialogs = ["You must be the warrior Zero!",
					   "I was on a journey to find the perfect place to do a painting.",
					   "But these bushes are getting in the way."]
					
	faceSprite.hframes = $Sprite2D.hframes
	faceSprite.vframes = $Sprite2D.vframes
	faceSprite.frame = $Sprite2D.frame
	faceSprite.texture = $Sprite2D.texture

func _on_Area2D_body_entered(body):
	if not GameState.check_body_is_player(body):
		return
		
	if characterName == 'Death':
		GameState.player_stop_moving()
		
	dialogBox.start_dialog(self.characterName, self.dialogs)

func _on_Area2D_body_exited(body):
	dialogBox.end_dialog()
	
func _on_dialogue_ended():
	if characterName == 'Death':
		GameState.goto_title_screen()
