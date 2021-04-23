class_name Undead extends Enemy

var follow_player: bool = false
var move: Vector2 = Vector2.ZERO
var player
onready var Ballon = $Balloon
onready var InterrogationTime = $InterrogationTime
var alert_texture: Texture = preload("res://enemies/Enemy/Balloons/alert.png")
var suspicious_texture: Texture = preload("res://enemies/Enemy/Balloons/suspicious.png")
var player_is_on_vision: bool = false

func _ready():
	speed = 20
	sprite_hurt = preload("res://enemies/Undead/undead_hurt.png")
	health = 3


func _physics_process(delta):
	move = Vector2.ZERO
	
	if is_hurt:
		move_and_slide(pushed_move_direction.normalized() * (speed * 2))
	elif player_is_on_vision and GameState.check_line_of_sight(self, player):
		enemy_saw_player()
		move = global_position.direction_to(player.global_position) * (speed * 2)
		move_and_slide(move, Vector2(0, 0))
	else:
		if not move_random_direction:
			Ballon.texture = suspicious_texture
			InterrogationTime.start()
			
		enemy_lost_sight_of_player()


func _on_Vision_body_entered(body):
	if player == null:
		player = GameState.get_player()
		
	if GameState.check_body_is_player(body):
		player_is_on_vision = true


func _on_Vision_body_exited(body):
	if GameState.check_body_is_player(body):
		player_is_on_vision = false

	
func enemy_saw_player():
	Ballon.texture = alert_texture
	move_random_direction = false
	
	
func enemy_lost_sight_of_player():
	move_random_direction = true


func _on_InterrogationTime_timeout():
	Ballon.texture = null
