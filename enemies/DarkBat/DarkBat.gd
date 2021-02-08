class_name DarkBat extends KinematicBody2D

enum Direction {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

var rng = RandomNumberGenerator.new()
var move_direction = Vector2.ZERO
var speed = 50

func _ready():
	move_direction = get_random_direction()

func _physics_process(delta):
	move_and_slide(move_direction.normalized() * speed)
	
	
func get_random_direction() -> Vector2:
	rng.randomize()
	var direction = rng.randi_range(0, 3)
	
	match direction:
		Direction.UP:
			return Vector2.UP
		Direction.DOWN:
			return Vector2.DOWN
		Direction.LEFT:
			return Vector2.LEFT
		Direction.RIGHT:
			return Vector2.RIGHT
	
	return Vector2.ZERO


func _on_ChangeMovimentDirection_timeout():
	move_direction = get_random_direction()
