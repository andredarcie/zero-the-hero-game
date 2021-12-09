extends Control

onready var intro_sound : AudioStream = preload("res://sounds/effects/intro_monster.wav")

func _input(event):
	if event.is_action_pressed("ui_accept"):
		#SoundEffects.play_sound(intro_sound)
		$Timer.start()

func _on_Timer_timeout():
	LevelManager.change_scene("res://engine/Screens/IntroScreen.tscn")
