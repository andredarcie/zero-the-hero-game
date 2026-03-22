class_name CuttableTree extends Node2D

@onready var item = preload("res://items/Item.tscn")
@onready var cuting_wood : AudioStream = preload("res://pickups/wood/wood_cuting.wav")
@onready var cuting_drop : AudioStream = preload("res://pickups/wood/wood_drop.wav")
@onready var wardrobes_texture : Texture2D = preload("res://pickups/wood/wardrobes.png")

enum WoodType {
	OldTree,
	Wardrobe
}

@export var type: WoodType = WoodType.OldTree

func _ready():
	if type == WoodType.Wardrobe:
		$Tree/Sprite2D.texture = wardrobes_texture
	
	$Tree/Sprite2D.material = $Tree/Sprite2D.material.duplicate()
	if GameState.create_check(self):
		$Tree.queue_free()
		$Wood.visible = true
		$Wood/Area2D/CollisionShape2D.set_deferred("disabled", false)
	else:
		$Wood/Area2D/CollisionShape2D.set_deferred("disabled", true)
		
	
func flash_in():
	$Tree/Sprite2D.get_material().set_shader_parameter("hit_strength", 1)
	
func flash_out():
	$Tree/Sprite2D.get_material().set_shader_parameter("hit_strength", 0)

func _on_Tree_area_entered(area):
	if area.name == "sword": 
		if GameState.player_current_item_is_axe():
			if $Tree/Sprite2D.frame == 3:
				$Tree.queue_free()
				SoundEffects.play_sound(cuting_drop)
				GameState.destroy(self)
				$Wood.visible = true
				$Wood/Area2D/CollisionShape2D.set_deferred("disabled", false)
				return
				
			$Tree/AnimationPlayer.play("default")
			$Tree/Sprite2D.frame = $Tree/Sprite2D.frame + 1
			SoundEffects.play_sound(cuting_wood)
		else: 
			GameState.show_player_ballon_axe()
