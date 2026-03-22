class_name Respawn extends Node2D

@onready var Undead: PackedScene = preload("res://enemies/Undead/Undead.tscn")
@onready var Heart: PackedScene = preload("res://pickups/heart/Heart.tscn")
var rng = RandomNumberGenerator.new()

func _ready():	
	rng.randomize()
	var my_random_number = rng.randi_range(1, 100)
	if my_random_number <= 80:
		instance_scene(Undead)
	else:
		if GameState.player_health <= 1:
			instance_scene(Heart)
			
		instance_scene(Undead)
	
	
func instance_scene(scene: PackedScene) -> void:
	var new_scene = scene.instantiate()
	new_scene.global_position = global_position
	get_parent().call_deferred("add_child", new_scene)
	queue_free()
	
