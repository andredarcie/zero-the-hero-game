extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Timer_timeout():
	$AnimationPlayer.playback_speed = 4
	$AnimationPlayer.play("exploding")
	

func spread_the_blast_damage():
	for body in $Range.get_overlapping_bodies():
		if body.has_method("make_damage"):
			body.make_damage(self)
		if body.has_method("hurt"):
			body.hurt(self)
			
	for area in $Range.get_overlapping_areas():
		var parent = area.get_parent()
		if parent.has_method("catch_fire"):
			parent.catch_fire()
	
	
func destroy():
	spread_the_blast_damage()
	$Sprite.frame = 1
