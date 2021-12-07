class_name Item extends Node2D

enum ItemSlot {
	Nothing,
	Sword,
	Bow,
	Bomb,
	Scythe,
	Axe,
	Key
}

var sword_texture = preload("res://items/sword_icon.png")
var bow_texture = preload("res://player/BowArrow/bow.png")
var bomb_texture = preload("res://items/bomb_icon.png")
var scythe_texture = preload("res://items/scythe_icon.png")
var axe_texture = preload("res://items/axe_icon.png")
var key_texture = preload("res://items/key_icon.png")
var texture = null
export(ItemSlot) var item = ItemSlot.Nothing

func _ready():
	set_item_texture(item)

func set_item_texture(item):
	match item:
		ItemSlot.Sword:
			texture = sword_texture
		ItemSlot.Bow:
			texture = bow_texture
		ItemSlot.Bomb:
			texture = bomb_texture
		ItemSlot.Scythe:
			texture = scythe_texture
		ItemSlot.Axe:
			texture = axe_texture
		ItemSlot.Key:
			texture = key_texture
			
	$Sprite.texture = texture
	
func _on_Area2D_body_entered(body):
	if GameState.check_body_is_player(body):
		SoundEffects.play_get_item()
		var old_item = GameState.player_slot_item
		
		GameState.player_slot_item = item
		var player = GameState.get_player()
		print(player.name)
		player.change_item(item, texture)
		
		if old_item == ItemSlot.Nothing:
			queue_free()
		
		set_item_texture(old_item)
		
		item = old_item
