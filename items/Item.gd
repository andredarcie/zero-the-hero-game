class_name Item extends Node2D

var texture = null

enum ItemSlot {
	Nothing,
	Sword,
	Bow,
	Bomb,
	Scythe,
	Axe,
	Key
}

export(ItemSlot) var item = ItemSlot.Nothing

func _ready():
	var state = GameState.load_state(self)
	if state == -1:
		set_item_texture(item)
	elif state == 0:
		queue_free()
	else:
		set_item_texture(state)
		item = state
		

func set_item_texture(item):
	var texture = GameState.get_item_texture(item)
	$Sprite.texture = texture
	
	
func _on_Area2D_body_entered(body):
	if GameState.check_body_is_player(body):
		var old_item = GameState.player_slot_item
		GameState.save_state(self, old_item)
		
		GameState.player_slot_item = item
		var player = GameState.get_player()
		player.change_item(item, true)
		
		if old_item == GameState.ItemSlot.Nothing:
			queue_free()
		
		set_item_texture(old_item)
		item = old_item
