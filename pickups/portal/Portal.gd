class_name Portal extends Area2D

func _ready():
	visible = false
	
func _process(delta):
	if GameState.player_current_item_is_sword():
		visible = true
	else:
		visible = false
		
func _on_Portal_body_entered(body):
	if GameState.check_body_is_player(body) and visible:
		LevelManager.go_to_next_level()		
