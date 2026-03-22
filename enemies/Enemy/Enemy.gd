class_name Enemy extends CharacterBody2D

enum Direction {
	UP,
	DOWN,
	LEFT,
	RIGHT
}

var sprite_default: Texture2D

@onready var PoolOfBlood: PackedScene = preload("res://enemies/Enemy/PoolOfBlood/PoolOfBlood.tscn")
@onready var Coin: PackedScene = preload("res://pickups/coin/Coin.tscn")
@onready var HeartScene: PackedScene = preload("res://pickups/heart/Heart.tscn")
var rng = RandomNumberGenerator.new()
@onready var SceneNode = get_node("../../")

var invulnerable_to_arrows: bool = false
var move_direction = Vector2.ZERO
var facing_direction = Direction.DOWN
var pushed_move_direction = Vector2.ZERO
var is_hurt: bool = false
var is_hurt_blink: bool = false
var move_random_direction: bool = true
var speed = 50
var health = 1
var damage = 1
var player = null
@export var unique_id: String

var enemy_is_dead: bool = false

# Audios
var get_hurt_sound : AudioStream = null
var dying_sound : AudioStream = null

func _ready() -> void:
	if GameState.check_id(unique_id):
		queue_free()
		
	add_to_group("Enemy")
	sprite_default = $Sprite2D.texture
	move_direction = get_random_direction()
	
func _process(delta):
	if is_hurt_blink:
		$Sprite2D.modulate.a = 0.5 if Engine.get_frames_drawn() % 2 == 0 else 1.0
	else:
		$Sprite2D.modulate.a = 1.0
		
func _physics_process(delta) -> void:		
	if is_hurt:
		set_velocity(pushed_move_direction.normalized() * (speed * 2))
		move_and_slide()
	elif move_random_direction:
		var collision = move_and_collide(move_direction.normalized() * speed * delta)
		if collision:
			move_direction = get_random_direction()
	
	
func get_random_direction() -> Vector2:
	rng.randomize()
	var direction = rng.randi_range(0, 3)
	facing_direction = direction
	
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
	if "Arrow" in body.name and self.invulnerable_to_arrows:
		return
		
	pushed_move_direction = global_transform.origin - body.global_transform.origin
	$HurtTime.start()
	is_hurt = true
	
	var bomb_hit: bool = "Bomb" in body.name or body.get("type") == "explosion"
	if GameState.player_current_item_is_sword() or bomb_hit:
		health -= 1
		is_hurt_blink = true
		
		if get_hurt_sound:
			SoundEffects.play_sound(get_hurt_sound)
	else:
		if player == null:
			player = GameState.get_player()
		
		player.show_ballon_sword()


func _on_HurtTime_timeout() -> void:
	$HurtTime.stop()
	is_hurt = false
	is_hurt_blink = false
	if health <= 0:
		enemy_is_dead = true
		
		if dying_sound:
			SoundEffects.play_sound(dying_sound)
			
		instance_scene(PoolOfBlood)
		
		rng.randomize()
		var my_random_number = rng.randi_range(1, 10)
		
		if my_random_number >= 1 and my_random_number <= 5:
			instance_scene(Coin)
			
		if my_random_number >= 6 and my_random_number <= 7:
			instance_scene(HeartScene)
		
		
		GameState.activate_id(unique_id)
		queue_free()
	
		

func _on_Area2D_body_entered(body) -> void:
	if body.has_method("make_damage"):
		body.make_damage(self)
		
		
func instance_scene(scene: PackedScene) -> void:
	var new_scene = scene.instantiate()
	new_scene.global_position = global_position
	get_parent().call_deferred("add_child", new_scene)
	queue_free()
