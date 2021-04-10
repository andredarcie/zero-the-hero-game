class_name Undead extends Enemy

var follow_player: bool = false
var move: Vector2 = Vector2.ZERO
var player
onready var Ballon = $Balloon
var alert_texture: Texture = preload("res://enemies/Enemy/Balloons/alert.png")

func _ready():
	speed = 20
	sprite_hurt = preload("res://enemies/Undead/undead_hurt.png")
	health = 3


func _physics_process(delta):
	move = Vector2.ZERO
	
	if follow_player:
		if is_hurt:
			move_and_slide(pushed_move_direction.normalized() * (speed * 2))
		else:
			move = global_position.direction_to(player.global_position) * (speed * 2)
			move_and_slide(move, Vector2(0, 0))


func _on_Vision_body_entered(body):
	if player == null:
		player = GameState.get_player()
		
	if GameState.check_body_is_player(body):
		if GameState.check_line_of_sight(self, player):
			Ballon.texture = alert_texture
			follow_player = true
			move_random_direction = false


func _on_Vision_body_exited(body):
	if GameState.check_body_is_player(body):
		Ballon.texture = null
		follow_player = false
		move_random_direction = true
