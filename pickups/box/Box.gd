extends KinematicBody2D

enum MOVE_DIRECTION {
	Up,
	Down,
	Left,
	Right
}

var pushing = false
var end_position = Vector2.ZERO
var time = 0

onready var UpArea = $UpArea
onready var DownArea = $DownArea
onready var LeftArea = $LeftArea
onready var RightArea = $RightArea

func _physics_process(delta):
	if pushing:
		if global_position != end_position:
			time += delta * 1
			global_position = global_position.move_toward(end_position, time)
		else:
			pushing = false
			
	
func set_move(move_direction):
	if pushing:
		return
		
	var move_vector = Vector2.ZERO
	
	match move_direction:
		MOVE_DIRECTION.Up:
			if is_colliding(DownArea):
				return
				
			move_vector = Vector2(0, 16)
		MOVE_DIRECTION.Down:
			if is_colliding(UpArea):
				return
				
			move_vector = Vector2(0, -16)
		MOVE_DIRECTION.Left:
			if is_colliding(RightArea):
				return
				
			move_vector = Vector2(16, 0)
		MOVE_DIRECTION.Right:
			if is_colliding(LeftArea):
				return
				
			move_vector = Vector2(-16, 0)
			
	pushing = true
	end_position = global_position + move_vector
	
func is_colliding(area: Area2D):
	for body in area.get_overlapping_bodies():
		return body != null
	
func _on_UpArea_body_entered(body):
	set_move(MOVE_DIRECTION.Up)
	

func _on_DownArea_body_entered(body):
	set_move(MOVE_DIRECTION.Down)


func _on_LeftArea_body_entered(body):
	set_move(MOVE_DIRECTION.Left)


func _on_RightArea_body_entered(body):
	set_move(MOVE_DIRECTION.Right)
