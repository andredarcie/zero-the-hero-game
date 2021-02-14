class_name Bat extends Enemy

func _ready():
	sprite_default = preload("res://enemies/Bat/bat.png")
	sprite_hurt = preload("res://enemies/Bat/bat_hurt.png")
	move_random_direction = false
