extends Area2D

var active: bool = false

onready var Up: Area2D = $Up
onready var Down: Area2D = $Down
onready var Left: Area2D = $Left
onready var Right: Area2D = $Right

func _ready():
	add_to_group("Wire")


func toggle():		
	for child in get_overlapping_areas():
		if child.is_in_group("Wire") and child.has_method("toggle"):
			if active:
				turn_off()
			else:
				turn_on()
			

func turn_on():
	active = true
	$Sprite.frame = $Sprite.frame + 1
	
	
func turn_off():
	active = false
	$Sprite.frame = $Sprite.frame - 1
	

func _on_Wire_body_entered(body):
	toggle()
