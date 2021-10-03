class_name ArrowUndead extends Enemy

enum DIRECTION {
	Up,
	Down,
	Left,
	Right
}

onready var BowTimer = $BowTimer
var arrow_direction = DIRECTION.Down
var move: Vector2 = Vector2.ZERO
onready var arrow = preload("res://player/BowArrow/Arrow.tscn")

func _ready():
	invulnerable_to_arrows = true
	speed = 30
	health = 4
	get_hurt_sound = preload("res://sounds/effects/undead.wav")
	dying_sound = preload("res://sounds/effects/undead_dying.wav")
	BowTimer.start()


func _physics_process(delta):
	move = Vector2.ZERO
	
	if is_hurt:
		move_and_slide(pushed_move_direction.normalized() * (speed * 2))
		
func shoot_arrow() -> void:
	var new_arrow = arrow.instance()
	new_arrow.set_direction_and_point_of_origin(self.facing_direction, global_position)
	get_node('..').add_child(new_arrow)
	BowTimer.start()
	


func _on_BowTimer_timeout():
	shoot_arrow()
