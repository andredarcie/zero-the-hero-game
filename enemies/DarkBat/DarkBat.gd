class_name DarkBat extends KinematicBody2D

enum Direction {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

onready var sprite_hurt = preload("res://enemies/Bat/bat_hurt.png")
var sprite_default

var rng = RandomNumberGenerator.new()
var move_direction = Vector2.ZERO
var speed = 50
var health = 1
var is_hurt: bool = false
var pushed_move_drection = Vector2.ZERO
var damage = 1

func _ready():
	sprite_default = $Sprite.texture
	move_direction = get_random_direction()
	
func _physics_process(_delta):
	if is_hurt:
		move_and_slide(pushed_move_drection.normalized() * (speed * 2))
	else:
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


func hurt(body : Node2D):
	pushed_move_drection = global_transform.origin - body.global_transform.origin
	$Sprite.texture = sprite_hurt
	$HurtTime.start()
	is_hurt = true
	health -= 1


func _on_HurtTime_timeout():
	$Sprite.texture = sprite_default
	$HurtTime.stop()
	is_hurt = false
	if health <= 0:
		queue_free()


func _on_Area2D_body_entered(body):
	if body.has_method("make_damage"):
		body.make_damage(self)
