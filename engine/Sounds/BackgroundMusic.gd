extends Node2D

	
func stop():
	$AudioStreamPlayer.stop()
	
func play():
	$AudioStreamPlayer.play()
	
func play_sound(audio : AudioStream):
	
	$AudioStreamPlayer.stream = audio
	$AudioStreamPlayer.play()
	
func play_dungeon_sound():
	pass
	
func play_main_sound():
	pass
