extends Node2D

var on_fire: bool = false
var damage = 1
var ashes: bool = false

func _on_Timer_timeout():
	$Timer.stop()
	
	for child in $Area2D2.get_overlapping_areas():
		var parent = child.get_parent()
		if parent.has_method("catch_fire"):
			if not parent.ashes:
				parent.catch_fire()
	
	on_fire = false
	$AnimatedSprite.play("ashes")
	ashes = true
		
	
func catch_fire():
	on_fire = true
	$AnimatedSprite.speed_scale = 5
	$AnimatedSprite.play("fire")
	$Timer.start()


func _on_Area2D_area_entered(area):
	var parent = area.get_parent()
	if parent.has_method("get_fire_state"):
		if parent.get_fire_state():
			catch_fire()
