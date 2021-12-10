extends Control

func _ready():
	BackgroundMusic.stop()


func _on_Timer_timeout():
	BackgroundMusic.play_main_sound()
	LevelManager.current_player_position = Vector2(152, 168)
	Hud.hud_visible(true)
	LevelManager.change_scene("res://levels/4-3.tscn")
