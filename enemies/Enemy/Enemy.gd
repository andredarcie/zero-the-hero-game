class_name Enemy extends KinematicBody2D

enum Direction {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

var sprite_hurt: Texture
var sprite_default: Texture

var rng = RandomNumberGenerator.new()
var move_direction = Vector2.ZERO
var pushed_move_direction = Vector2.ZERO
var is_hurt: bool = false
var move_random_direction: bool = true
var speed = 50
var health = 1
var damage = 1

func _ready() -> void:
	add_to_group("Enemy")
	sprite_default = $Sprite.texture
	move_direction = get_random_direction()
	
	
func _physics_process(delta) -> void:
	if is_hurt:
		move_and_slide(pushed_move_direction.normalized() * (speed * 2))
	elif move_random_direction:
		var collision = move_and_collide(move_direction.normalized() * speed * delta)
		if collision:
			move_direction = get_random_direction()
	
	
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


func _on_ChangeMovimentDirection_timeout() -> void:
	move_direction = get_random_direction()


func hurt(body : Node2D) -> void:
	pushed_move_direction = global_transform.origin - body.global_transform.origin
	$Sprite.texture = sprite_hurt
	$HurtTime.start()
	is_hurt = true
	health -= 1


func _on_HurtTime_timeout() -> void:
	$Sprite.texture = sprite_default
	$HurtTime.stop()
	is_hurt = false
	if health <= 0:
		queue_free()


func _on_Area2D_body_entered(body) -> void:
	if body.has_method("make_damage"):
		body.make_damage(self)
