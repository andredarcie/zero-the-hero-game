class_name CuttableTree extends Node2D

onready var item = preload("res://items/Item.tscn")
onready var cuting_wood : AudioStream = preload("res://pickups/wood/wood_cuting.wav")
onready var cuting_drop : AudioStream = preload("res://pickups/wood/wood_drop.wav")

func _ready():
	$Tree/Sprite.material = $Tree/Sprite.material.duplicate()
	if GameState.create_check(self):
		$Tree/Sprite.frame = 4
		$Tree/StaticBody2D.queue_free()
		$Tree/CollisionShape2D.queue_free()
		$Wood.visible = true
		$Wood/Area2D/CollisionShape2D.set_deferred("disabled", false)
	else:
		$Wood/Area2D/CollisionShape2D.set_deferred("disabled", true)
		
	
func flash_in():
	$Tree/Sprite.get_material().set_shader_param("hit_strength", 1)
	
func flash_out():
	$Tree/Sprite.get_material().set_shader_param("hit_strength", 0)

func _on_Tree_area_entered(area):
	if area.name == "sword" and GameState.player_sword_cut_wood:
		
		if $Tree/Sprite.frame == 3:
			$Tree/Sprite.frame = $Tree/Sprite.frame + 1
			SoundEffects.play_sound(cuting_drop)
			$Tree/StaticBody2D.queue_free()
			$Tree/CollisionShape2D.queue_free()
			GameState.destroy(self)
			$Wood.visible = true
			$Wood/Area2D/CollisionShape2D.set_deferred("disabled", false)
			return
			
		$Tree/AnimationPlayer.play("default")
		$Tree/Sprite.frame = $Tree/Sprite.frame + 1
		SoundEffects.play_sound(cuting_wood)
