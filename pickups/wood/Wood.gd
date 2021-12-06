extends Area2D

onready var CutWood = preload("res://pickups/wood/cut_wood/CutWood.tscn")
onready var cuting_wood : AudioStream = preload("res://pickups/wood/wood_cuting.wav")
onready var cuting_drop : AudioStream = preload("res://pickups/wood/wood_drop.wav")

func _ready():
	$Sprite.material = $Sprite.material.duplicate()
	if GameState.create_check(self):
		$Sprite.frame = 4
		$StaticBody2D.queue_free()
		$CollisionShape2D.queue_free()
	
func flash_in():
	$Sprite.get_material().set_shader_param("hit_strength", 1)
	
func flash_out():
	$Sprite.get_material().set_shader_param("hit_strength", 0)

func _on_Wood_area_entered(area):
	if area.get_parent().name == "sword" and GameState.player_sword_cut_wood:
		
		if $Sprite.frame == 3:
			$Sprite.frame = $Sprite.frame + 1
			SoundEffects.play_sound(cuting_drop)
			$StaticBody2D.queue_free()
			$CollisionShape2D.queue_free()
			instance_scene(CutWood)
			GameState.destroy(self)
			return
			
		$AnimationPlayer.play("default")
		$Sprite.frame = $Sprite.frame + 1
		SoundEffects.play_sound(cuting_wood)
		
	
	
func instance_scene(scene: PackedScene) -> void:
	var new_scene = scene.instance()
	new_scene.global_position = Vector2(global_position.x, global_position.y)
	get_parent().call_deferred("add_child", new_scene)
