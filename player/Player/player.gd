class_name Player extends KinematicBody2D

onready var FootSteps = preload("res://player/FootSteps/FootSteps.tscn")
onready var blood_particules = preload("res://enemies/Enemy/Blood/Blood.tscn")

var state: String = 'default'
var step_interval = 4
var type: String = 'player'
var max_health: int = 0
var health: int = 4
var speed: float = 70
var movedir := Vector2.ZERO
var sprite_direction: String = 'down'
var hitstun: int = 0
var knockdir: Vector2 = Vector2.ZERO

var texture_default: Texture = null
var texture_hurt: Texture = null

# Items
var sword = preload('res://items/sword.tscn')
var sword_on_fire: bool = false

onready var arrow = preload("res://player/BowArrow/Arrow.tscn")
var arrow_direction = DIRECTION.Up

enum DIRECTION {
	Up,
	Down,
	Left,
	Right
}

func _init() -> void:
	type = 'player'
	max_health = GameState.player_max_health
	health = GameState.player_health
	
	
func _ready() -> void:
	speed = 90
	$Bow.visible = false
	add_to_group('Player')
	texture_default = $Sprite.texture
	texture_hurt = preload("res://player/Player/hero_hurt.png")


func _physics_process(_delta: float) -> void:
	match state:
		'default':
			state_default()
		'swing':
			state_swing()

	
func state_default() -> void:
	if step_interval > 0:
		step_interval -= 1
	elif step_interval == 0:
		step_interval = 5
		var foot_steps = FootSteps.instance()
		foot_steps.global_position = $Foots.global_position
		get_parent().add_child(foot_steps)
	
	controls_loop()
	movement_loop()
	spriterdir_loop()
	damage_loop()
	
	LevelManager.check_current_level(movedir, global_position)
	
	match movedir:
		Vector2(-1, 0):
			$AnimationPlayer.play("walking")
			$Sprite.flip_h = true
		Vector2(1, 0):
			$AnimationPlayer.play("walking")
			$Sprite.flip_h = false
		Vector2(0, -1):
			$AnimationPlayer.play("walking_up")
		Vector2(-1, -1):
			$AnimationPlayer.play("walking_up")
		Vector2(0, 1):
			$AnimationPlayer.play("walking_down")
		Vector2(1, 1):
			$AnimationPlayer.play("walking_down")
		Vector2(-1, 1):
			$AnimationPlayer.play("walking_down")
		Vector2(0, 0):
			$AnimationPlayer.play("idle")
	
	if Input.is_action_just_pressed("a"):
		use_item(sword)
		
	if Input.is_action_just_pressed("b"):
		shoot_arrow()

func state_swing() -> void:
	movement_loop()
	damage_loop()
	movedir = dir.center
	

func controls_loop() -> void:
	var LEFT: bool  = Input.is_action_pressed("ui_left")
	var RIGHT: bool = Input.is_action_pressed("ui_right")
	var UP: bool    = Input.is_action_pressed("ui_up")
	var DOWN: bool  = Input.is_action_pressed("ui_down")
	
	movedir.x = -int(LEFT) + int(RIGHT)
	movedir.y = -int(UP) + int(DOWN)


func sword_catch_fire():
	sword_on_fire = true
	$SwordOnFireTimer.start()


func _on_SwordOnFireTimer_timeout():
	sword_on_fire = false
	$SwordOnFireTimer.stop()
	
	
func add_coin():
	GameState.coins += 1
	
	
func set_arrow_direction() -> void:
	match sprite_direction:
		'left':
			set_bow_position_and_rotation(-11.024, 0, 136)
			arrow_direction = DIRECTION.Left
		'right':
			set_bow_position_and_rotation(8.504, 0.315, -45)
			arrow_direction = DIRECTION.Right
		'up':
			set_bow_position_and_rotation(0.112, -11.136, 225.1)
			arrow_direction = DIRECTION.Up
		'down':
			set_bow_position_and_rotation(0.112, 11.582, 45)
			arrow_direction = DIRECTION.Down


func set_bow_position_and_rotation(x: float, y: float, rotation_degress: float) -> void:
	$Bow.position.x = x
	$Bow.position.y = y
	$Bow.rotation_degrees = rotation_degress
	

func shoot_arrow() -> void:
	if GameState.player_arrows > 0:
		GameState.player_arrows -= 1
		set_arrow_direction()
		$Bow.visible = true
		var new_arrow = arrow.instance()
		new_arrow.set_direction_and_point_of_origin(arrow_direction, global_position)
		get_node('..').add_child(new_arrow)
		$Bow/BowTimer.start()


func _on_BowTimer_timeout() -> void:
	$Bow.visible = false
	$Bow/BowTimer.stop()


func movement_loop() -> void:
	var motion
	if hitstun == 0:
		motion = movedir.normalized() * speed
	else:
		motion = knockdir.normalized() * 125
		
	# warning-ignore:return_value_discarded
	move_and_slide(motion, Vector2(0, 0))
	
	
func spriterdir_loop() -> void:
	match movedir:
		Vector2.LEFT:
			sprite_direction = 'left'
		Vector2.RIGHT:
			sprite_direction = 'right'
		Vector2.UP:
			sprite_direction = 'up'
		Vector2.DOWN:
			sprite_direction = 'down'


func damage_loop() -> void:	
	if hitstun > 0:
		hitstun -= 1
		$Sprite.texture = texture_hurt
	else:
		$Sprite.texture = texture_default
		if type == 'enemy' && health <= 0:
			var drop = randi() % 2
			if drop == 0:
				instance_scene(preload("res://pickups/heart.tscn"))
			instance_scene(preload("res://enemies/Enemy/EnemyDeath/enemy_death.tscn"))
			queue_free()
		
	for area in $hitbox.get_overlapping_areas():
		var body = area.get_parent()
		
		if area.is_in_group("ranges"):
			continue
		
		if body.is_in_group("bullets") and not body.get("can_make_damage"):
			continue
			
		if body.is_in_group("bullets") and body.get("can_make_damage"):
			make_damage(body)
			body.queue_free()
			continue
		
		if  "Bonfire" in area.name:
			body = area
		
		if area.name == "Vision":
			continue
		
		if "Grass" in body.name:
			if body.get("on_fire"):
				make_damage(body)
		elif hitstun == 0 and body.get('damage') != null and body.get('type') != type:
			make_damage(body)


func make_damage(body) -> void:
	if body.get('damage') != null:
		health -= body.get('damage')
	else:
		health -= 1
		
	hitstun = 10
	knockdir = global_transform.origin - body.global_transform.origin
		
	if type == 'player':
		GameState.player_health = health
			
	if type == 'player' and health <= 0:
		GameState.restart_game()
		
	var blood = blood_particules.instance()
	add_child(blood)
	
	
func use_item(item: PackedScene) -> void:
	var newitem = item.instance()
	newitem.add_to_group(str(newitem.get_name(), self))
	add_child(newitem)

	if get_tree().get_nodes_in_group(str(newitem.get_name(), self)).size() > newitem.maxamount:
		newitem.queue_free()
		
		
func instance_scene(scene: PackedScene) -> void:
	var new_scene = scene.instance()
	new_scene.global_position = global_position
	get_parent().add_child(new_scene)
