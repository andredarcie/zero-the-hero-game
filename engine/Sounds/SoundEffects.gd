extends AudioStreamPlayer

onready var enter : AudioStream = preload("res://sounds/effects/enter.wav")
onready var hero_hurt : AudioStream = preload("res://sounds/effects/hero_hurt.wav")

func stop_sound():
	stop()
	
func play_sound(sound : AudioStream):
	stream = sound
	play()


func _on_SoundEffects_finished():
	stop_sound()
	
func play_enter():
	stop()
	play_sound(enter)
	
func play_hero_hurt():
	stop()
	play_sound(hero_hurt)
