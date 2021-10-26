extends AudioStreamPlayer

onready var enter : AudioStream = preload("res://sounds/effects/enter.wav")
onready var hero_hurt : AudioStream = preload("res://sounds/effects/hero_hurt.wav")
onready var health_potion : AudioStream = preload("res://sounds/effects/health_potion.wav")
onready var switch_sound : AudioStream = preload("res://sounds/effects/switch_sound.wav")
onready var bridge : AudioStream = preload("res://sounds/effects/bridge.wav")

func stop_sound():
	stop()
	
func play_sound(sound : AudioStream):
	var audio_stream_player: Node
	audio_stream_player = AudioStreamPlayer.new()
	get_parent().add_child(audio_stream_player)
	audio_stream_player.stream = sound
	audio_stream_player.play()
	audio_stream_player.connect("finished", audio_stream_player, "queue_free")


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
	
func play_bridge_sound():
	stop()
	play_sound(bridge)
