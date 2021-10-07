class_name Respawn extends Node2D

onready var Undead: PackedScene = preload("res://enemies/Undead/Undead.tscn")
var rng = RandomNumberGenerator.new()

func _ready():
	rng.randomize()
	var my_random_number = rng.randi_range(0, 1)
	if my_random_number == 1:
		instance_scene(Undead)
	else:
		queue_free()
	
	
func instance_scene(scene: PackedScene) -> void:
	var new_scene = scene.instance()
	new_scene.global_position = global_position
	get_parent().call_deferred("add_child", new_scene)
	queue_free()
	
