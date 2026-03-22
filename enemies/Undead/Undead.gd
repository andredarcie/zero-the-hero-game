class_name Undead extends Enemy

var follow_player: bool = false
var move: Vector2 = Vector2.ZERO
@onready var Ballon = $Balloon
@onready var InterrogationTime = $InterrogationTime
var alert_texture: Texture2D = preload("res://enemies/Enemy/Balloons/alert.png")
var suspicious_texture: Texture2D = preload("res://enemies/Enemy/Balloons/suspicious.png")
var player_is_on_vision: bool = false
var can_play_alert_sound: bool = true

func _ready():
	set_physics_process(false)
	$Sprite2D.visible = false
	$AnimatedSprite2D.play()
	
	speed = 20
	health = 2
	move_random_direction = false
	get_hurt_sound = preload("res://sounds/effects/undead.wav")
	dying_sound = preload("res://sounds/effects/undead_dying.wav")
	player = GameState.get_player()


func _physics_process(delta):
	move = Vector2.ZERO
	
	if is_hurt:
		set_velocity(pushed_move_direction.normalized() * (speed * 2))
		move_and_slide()
	elif player_is_on_vision and GameState.check_line_of_sight(self, $Area2D, player):
		enemy_saw_player()
		move = global_position.direction_to(player.global_position) * (speed * 2)
		set_velocity(move)
		set_up_direction(Vector2(0, 0))
		move_and_slide()
	else:
		if not move_random_direction:
			Ballon.texture = suspicious_texture
			InterrogationTime.start()
			
		enemy_lost_sight_of_player()
		var collision = move_and_collide(move_direction.normalized() * speed * delta)
		if collision:
			move_direction = get_random_direction()

func enemy_saw_player():
	if can_play_alert_sound:
		can_play_alert_sound = false
		SoundEffects.play_undead()
		$AlertTimer.start()
		
	Ballon.texture = alert_texture
	move_random_direction = false
	
	
func enemy_lost_sight_of_player():
	move_random_direction = true


func _on_InterrogationTime_timeout():
	Ballon.texture = null


func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite2D.queue_free()
	move_random_direction = true
	set_physics_process(true)
	$Sprite2D.visible = true


func _on_Vision_area_entered(area):
	if area.name == 'hitbox':
		player_is_on_vision = true


func _on_Vision_area_exited(area):
	if area.name == 'hitbox':
		player_is_on_vision = false


func _on_AlertTimer_timeout():
	can_play_alert_sound = true
