extends Node2D

onready var AudioFile = preload("res://sounds/background/405220-shortiefoeva2-playground.mp3")

func stop():
	$AudioStreamPlayer.stop()
	
func play():
	$AudioStreamPlayer.play()
	
func play_sound(audio : AudioStream):
	$AudioStreamPlayer.stream = audio
	$AudioStreamPlayer.play()
	
func play_dungeon_sound():
	pass
	
func play_main_sound():
	play_sound(AudioFile)
