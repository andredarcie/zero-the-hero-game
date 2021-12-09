extends Node2D

var on_fire: bool = false
var damage = 1
var ashes: bool = false
export(bool) var is_brush = false

func _ready():
	if is_brush:
		$AnimatedSprite.visible = false
		$Sprite.visible = true
		
		if GameState.create_check(self):
			$Sprite.visible = false
			$Sprite.queue_free()
			$StaticBody2D.queue_free()
	else:
		$Sprite.queue_free()
		$StaticBody2D.queue_free()
		

func _on_Timer_timeout():
	$Timer.stop()
	
	for child in $Area2D2.get_overlapping_areas():
		var parent = child.get_parent()
		if parent.has_method("catch_fire"):
			if not parent.ashes:
				parent.catch_fire()
	
	on_fire = false
	$Light2D.visible = false
	$AnimatedSprite.play("ashes")
	ashes = true
		
	
func catch_fire():
	if ashes or on_fire:
		return
		
	on_fire = true
	$AnimatedSprite.visible = true
	$AnimatedSprite.speed_scale = 5
	$AnimatedSprite.play("fire")
	$Light2D.visible = true
	
	if is_brush:
		if not $Sprite == null: 
			$Sprite.queue_free()
			
		$StaticBody2D.queue_free()
		GameState.destroy(self)
		
	$Timer.start()


func _on_Area2D_area_entered(area):
	var parent = area.get_parent()
	if parent.has_method("get_fire_state"):
		if parent.get_fire_state():
			catch_fire()
