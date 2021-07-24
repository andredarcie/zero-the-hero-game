class_name FireMage extends Enemy

onready var mage_magic_texture: Texture = preload("res://enemies/FireMage/mage_magic.png")
onready var MagicBall: PackedScene = preload("res://enemies/FireMage/MagicBall/MagicBall.tscn")
onready var mage_hurt: Texture = preload("res://enemies/FireMage/mage_hurt.png")

var player_in_vision: bool = false

func _ready():
	health = 5
	

func shoot_magic_ball():
	var magic_ball = MagicBall.instance()
	magic_ball.global_position = global_position
	SceneNode.add_child(magic_ball)
	
func load_magic_ball():
	$EnemyAnimationPlayer.play("stop")
	move_random_direction = false
	$Sprite.texture = mage_magic_texture
	$LoadingMagic.start()
	
func _on_Vision_body_entered(body):
	if body.is_in_group("Player"):
		player_in_vision = true
		load_magic_ball()


func _on_Vision_body_exited(body):
	if body.is_in_group("Player"):
		$Sprite.texture = sprite_default
		player_in_vision = false


func _on_LoadingMagic_timeout():
	$EnemyAnimationPlayer.play("default")
	move_random_direction = true
	$LoadingMagic.stop()
	$Sprite.texture = sprite_default
	shoot_magic_ball()
	
	if player_in_vision:
		load_magic_ball()
