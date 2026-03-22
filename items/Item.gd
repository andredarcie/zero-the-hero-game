class_name Item extends Node2D

var texture = null

enum ItemSlot {
	Nothing,
	Sword,
	Bow,
	Bomb,
	Scythe,
	Axe,
	Key,
	Pickaxe,
	Wood,
	WoodOnFire,
	LavaBoots
}

@export var item: ItemSlot = ItemSlot.Nothing
	
func _ready():
	var state = GameState.load_state(self)
	print('estado: ', state)
	if state == -1:
		set_item_texture(item)
	elif state == 0:
		queue_free()
	else:
		set_item_texture(state)
		item = state

func set_item_texture(item):
	var texture = GameState.get_item_texture(item)
	$Sprite2D.texture = texture
	
	
func _on_Area2D_body_entered(body):
	if GameState.check_body_is_player(body):
		if GameState.player_slot_item == ItemSlot.WoodOnFire:
			GameState.player_slot_item = ItemSlot.Wood
			
		var old_item = GameState.player_slot_item
		GameState.change_player_item(item, true)
		
		if old_item == GameState.ItemSlot.Nothing or old_item == item:
			GameState.destroy(self)
			queue_free()
			return

		GameState.save_state(self, old_item)
		
		set_item_texture(old_item)
		item = old_item
