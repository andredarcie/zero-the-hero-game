extends Node2D

onready var wind_in_forest_sound : AudioStream = preload("res://sounds/background/wind-in-forest.wav")

func _ready():
	$AudioStreamPlayer2D.stream = wind_in_forest_sound
	$AudioStreamPlayer2D.play()
