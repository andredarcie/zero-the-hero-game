extends Control

func _ready():
	BackgroundMusic.stop()


func _on_Timer_timeout():
	BackgroundMusic.play_main_sound()
	Hud.hud_visible(true)
	LevelManager.go_to_first_level()
