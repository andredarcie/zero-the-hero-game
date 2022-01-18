extends Control

onready var intro_sound : AudioStream = preload("res://sounds/effects/intro_monster.wav")
var skip_intro: bool = true
var one_item_hero: bool = true

func _input(event):
	if one_item_hero:
		LevelManager.change_scene("res://levels/dungeons/first/1.tscn")
		
	if event.is_action_pressed("ui_accept"):
		#SoundEffects.play_sound(intro_sound)
		$Timer.start()
		
		
	if event is InputEventScreenTouch:
		if event.is_pressed():
			$Timer.start()
			
func _on_Timer_timeout():
	if skip_intro:
		BackgroundMusic.play_main_sound()
		LevelManager.current_player_position = Vector2(152, 168)
		LevelManager.change_scene("res://levels/4-3.tscn")
		Hud.draw_mini_map()
		Hud.set_player_position_on_mini_map(4, 3)
		Hud.set_place_discovered_on_mini_map(4, 3)
		return
		
	LevelManager.change_scene("res://engine/Screens/IntroScreen.tscn")
