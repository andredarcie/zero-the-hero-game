extends Node2D

onready var wind_in_forest_sound : AudioStream = preload("res://sounds/background/578921__bloodpixelhero__valley-of-hope.wav")
onready var dungeon_sound : AudioStream = preload("res://sounds/background/577007__bloodpixelhero__inner-ghost.wav")
onready var main_sound : AudioStream = preload("res://sounds/background/577561__bloodpixelhero__out-of-view.wav")

	
func stop():
	$AudioStreamPlayer.stop()
	
func play():
	$AudioStreamPlayer.play()
	
func play_sound(audio : AudioStream):
	
	$AudioStreamPlayer.stream = audio
	$AudioStreamPlayer.play()
	
func play_dungeon_sound():
	self.play_sound(dungeon_sound)
	
func play_main_sound():
	self.play_sound(main_sound)
