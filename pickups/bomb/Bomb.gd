extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Timer_timeout():
	for body in $Range.get_overlapping_bodies():
		if body.has_method("make_damage"):
			body.make_damage(self)
		
	queue_free()
