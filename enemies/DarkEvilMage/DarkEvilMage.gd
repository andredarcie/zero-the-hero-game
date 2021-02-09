extends KinematicBody2D
class_name DarkEvilMage

onready var magic_texture = preload("res://enemies/DarkEvilMage/evil_mage_magic.png")
var default_texture = null
onready var MagicBall = preload("res://enemies/DarkEvilMage/MagicBall.tscn")
onready var SceneNode = get_node("../../")
var move_direction = Vector2.ZERO
var speed = 100

func _ready():
	see()
	

func _physics_process(delta):
	move_direction = Helpers.get_random_direction()
	move_and_slide(move_direction.normalized() * speed)

func shoot_magic_ball():
	var magic_ball = MagicBall.instance()
	magic_ball.global_position = global_position
	SceneNode.add_child(magic_ball)


func see():
	$LoadMagicTimer.start()
	default_texture = $Sprite.texture
	$Sprite.texture = magic_texture
	

func _on_ShootMagicBallTimer_timeout():
	$Sprite.texture = default_texture
	shoot_magic_ball()


func _on_LoadMagicTimer_timeout():
	$ShootMagicBallTimer.start()
	
