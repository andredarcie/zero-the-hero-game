extends Area2D

@export var dungeon_name: String = "first"
@onready var DungeonScreen = preload("res://engine/Screens/DungeonScreen.tscn")

func _ready():
	if GameState.dungeon_one_finished:
		$Item.visible = true
		$Item/Area2D/CollisionShape2D.set_deferred("disabled", false)
	else:
		$Item.visible = false
		$Item/Area2D/CollisionShape2D.set_deferred("disabled", true)


func _on_DungeonEntrance_body_entered(body):
	if GameState.check_body_is_player(body):
		
		if GameState.player_current_item_is_sword():
			GameState.player_current_dungeon_exit_position = $ExitPosition2D.global_position
			LevelManager.current_player_position = Vector2(32,32)
			GameState.player_current_dungeon_name = dungeon_name
			
			get_tree().change_scene_to_packed(DungeonScreen)
		else:
			GameState.show_player_ballon_sword()
