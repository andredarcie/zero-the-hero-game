extends KinematicBody2D

func _physics_process(delta):
	var move = Vector2(1, 0)
	move_and_collide(move)
