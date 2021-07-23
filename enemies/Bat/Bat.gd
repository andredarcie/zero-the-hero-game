class_name Bat extends Enemy

func _ready():
	sprite_default = preload("res://enemies/Bat/bat.png")
	health =  1
	get_hurt_sound = preload("res://sounds/effects/monster.wav")
