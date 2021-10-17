extends Area2D

onready var CutWood = preload("res://pickups/wood/cut_wood/CutWood.tscn")

func _on_Wood_area_entered(area):
	if area.get_parent().name == "sword":
		if $Sprite.frame == 3:
			$Sprite.frame = $Sprite.frame + 1
			$StaticBody2D.queue_free()
			$CollisionShape2D.queue_free()
			instance_scene(CutWood)
			return
			
		$AnimationPlayer.play("default")
		$Sprite.frame = $Sprite.frame + 1
	
	
func instance_scene(scene: PackedScene) -> void:
	var new_scene = scene.instance()
	new_scene.global_position = Vector2(global_position.x, global_position.y + 16)
	get_parent().call_deferred("add_child", new_scene)
