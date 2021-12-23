extends Control

onready var intro_sound : AudioStream = preload("res://sounds/effects/intro_monster.wav")
var skip_intro: bool = false

func _input(event):
	if event.is_action_pressed("ui_accept"):
		#SoundEffects.play_sound(intro_sound)
		$Timer.start()

func _on_Timer_timeout():
	if skip_intro:
		BackgroundMusic.play_main_sound()
		LevelManager.current_player_position = Vector2(152, 168)
		LevelManager.change_scene("res://levels/4-3.tscn")
		return
		
	LevelManager.change_scene("res://engine/Screens/IntroScreen.tscn")
