class_name Wire extends Node2D

export var active: bool = false

enum Types {
	VERTICAL
	HORIZONTAL
	CURVE_UP_RIGHT
	CURVE_RIGHT_DOWN
	CURVE_DOWN_LEFT
	CURVE_LEFT_UP	
}

onready var Up: Area2D = $Up
onready var Down: Area2D = $Down
onready var Left: Area2D = $Left
onready var Right: Area2D = $Right

export(Types) var type

var next_wire_name

func _ready():
	add_to_group("Wire")
	
	match type:
		Types.VERTICAL:
			$Sprite.frame = 0
			Left.queue_free()
			Right.queue_free()
		Types.HORIZONTAL:
			$Sprite.frame = 2
			Up.queue_free()
			Down.queue_free()
		Types.CURVE_UP_RIGHT:
			$Sprite.frame = 4
			Left.queue_free()
			Down.queue_free()
		Types.CURVE_RIGHT_DOWN:
			$Sprite.frame = 10
			Left.queue_free()
			Up.queue_free()
		Types.CURVE_DOWN_LEFT:
			$Sprite.frame = 8
			Up.queue_free()
			Right.queue_free()
		Types.CURVE_LEFT_UP:
			$Sprite.frame = 6
			Right.queue_free()
			Down.queue_free()


func toggle(name: String):		
	active = !active
	
	if active:
		$Sprite.frame = $Sprite.frame + 1
	else: 
		$Sprite.frame = $Sprite.frame - 1		
				
	next_wire_name = name
	$Timer.start()
	

func on(name: String):
	active = true
	$Sprite.frame = $Sprite.frame + 1
	next_wire_name = name
	$Timer.start()
	
	
func off(name: String):
	active = false
	$Sprite.frame = $Sprite.frame - 1
	next_wire_name = name
	$Timer.start()
			

func get_next_area(area: Area2D):
	for child in area.get_overlapping_areas():
		var parent =  child.get_parent()
		if parent.is_in_group("Wire") and parent.has_method("toggle"):
			parent.toggle(child.name)
			return
		elif parent.is_in_group("LogicGate") and parent.has_method("toggle_input"):
			parent.toggle_input(child.name)


func _on_Timer_timeout():
	$Timer.stop()
	match next_wire_name:
		"Up":
			if type == Types.VERTICAL:
				get_next_area(Down)
			elif type == Types.CURVE_UP_RIGHT:
				get_next_area(Right)
			elif type == Types.CURVE_LEFT_UP:
				get_next_area(Left)
		"Down":
			if type == Types.VERTICAL:
				get_next_area(Up)
			elif type == Types.CURVE_RIGHT_DOWN:
				get_next_area(Right)
			elif type == Types.CURVE_DOWN_LEFT:
				get_next_area(Left)
		"Left":
			if type == Types.HORIZONTAL:
				get_next_area(Right)
			elif type == Types.CURVE_LEFT_UP:
				get_next_area(Up)
			elif type == Types.CURVE_DOWN_LEFT:
				get_next_area(Down)
		"Right":
			if type == Types.HORIZONTAL:
				get_next_area(Left)
			elif type == Types.CURVE_RIGHT_DOWN:
				get_next_area(Down)
			elif type == Types.CURVE_UP_RIGHT:
				get_next_area(Up)
