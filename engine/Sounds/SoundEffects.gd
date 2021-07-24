extends AudioStreamPlayer

onready var enter : AudioStream = preload("res://sounds/effects/enter.wav")
onready var hero_hurt : AudioStream = preload("res://sounds/effects/hero_hurt.wav")
onready var health_potion : AudioStream = preload("res://sounds/effects/health_potion.wav")
onready var switch_sound : AudioStream = preload("res://sounds/effects/switch_sound.wav")

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
	
func play_health_potion():
	stop()
	play_sound(health_potion)
	
func play_switch_sound():
	stop()
	play_sound(switch_sound)
