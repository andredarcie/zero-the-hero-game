extends Node2D

func _on_Area2D_area_entered(area):
	if area.get_parent().name == "sword" and GameState.player_slot_item == 7:
		queue_free()
