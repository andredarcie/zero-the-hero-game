extends Node2D

onready var wind_in_forest_sound : AudioStream = preload("res://sounds/background/578921__bloodpixelhero__valley-of-hope.wav")

func _ready():
	$AudioStreamPlayer.stream = wind_in_forest_sound
	$AudioStreamPlayer.play()
	
func stop():
	$AudioStreamPlayer.stop()
	
func play():
	$AudioStreamPlayer.play()
