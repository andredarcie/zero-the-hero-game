extends CharacterBody2D

@onready var player: Player = GameState.get_player()

var last_player_position
var move = Vector2.ZERO
var look_vector = Vector2.ZERO
var damage = 1
var invert_moviment = false
var can_make_damage = false

func _ready():
	look_vector = player.position - global_position


func _physics_process(delta):
	move = Vector2.ZERO
	
	move = move.move_toward(look_vector, delta)
	move = move.normalized() * 3
	
	if invert_moviment:
		position -= move
	else:
		position += move


func _on_ExistenceTimer_timeout():
	queue_free()


func _on_Area2D_area_entered(area):
	var parent = area.get_parent()
	if parent.name == "sword":
		invert_moviment = true


func _on_DamageTimer_timeout():
	can_make_damage = true
	

func _on_Area2D_body_entered(body):
	if can_make_damage and body.has_method("hurt"):
		body.hurt(body)
		
func get_fire_state():
	return true
