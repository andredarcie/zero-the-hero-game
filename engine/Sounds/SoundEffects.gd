extends AudioStreamPlayer

func stop_sound():
	stop()
	
func play_sound(sound : AudioStream):
	stream = sound
	play()
