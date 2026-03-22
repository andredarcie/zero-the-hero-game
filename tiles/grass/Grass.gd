extends Node2D

var on_fire: bool = false
var damage = 1
var ashes: bool = false
@export var is_brush: bool = false

func _ready():
	if is_brush:
		$AnimatedSprite2D.visible = false
		$Sprite2D.visible = true
		
		if GameState.create_check(self):
			$Sprite2D.visible = false
			$Sprite2D.queue_free()
			$StaticBody2D.queue_free()
	else:
		$Sprite2D.queue_free()
		$StaticBody2D.queue_free()
		

func _on_Timer_timeout():
	$Timer.stop()
	
	for child in $Area2D2.get_overlapping_areas():
		var parent = child.get_parent()
		if parent.has_method("catch_fire"):
			if not parent.ashes:
				parent.catch_fire()
	
	on_fire = false
	$PointLight2D.visible = false
	$AnimatedSprite2D.play("ashes")
	ashes = true
		
	
func catch_fire():
	if ashes or on_fire:
		return
		
	on_fire = true
	$AnimatedSprite2D.visible = true
	$AnimatedSprite2D.speed_scale = 5
	$AnimatedSprite2D.play("fire")
	$PointLight2D.visible = true
	
	if is_brush:
		if not $Sprite2D == null: 
			$Sprite2D.queue_free()
			
		$StaticBody2D.queue_free()
		GameState.destroy(self)
		
	$Timer.start()


func _on_Area2D_area_entered(area):
	if area.name == "sword" and GameState.player_current_item_is_wood_on_fire():
		catch_fire()
