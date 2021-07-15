class_name AcceptTextBox extends RichTextLabel

var dialog =  []
var page: int = 0
var can_pass_to_next_dialog: bool = false
var dialog_ended: bool = false
var voice_sound = preload("res://npcs/mage/BeepBox-Song (2) (mp3cut.net).wav")
onready var audio_player: AudioStreamPlayer2D = $"../AudioStreamPlayer2D"

func _ready():
	set_visible(false)

func _input(event):
	if event.is_action_pressed("ui_accept") and can_pass_to_next_dialog:
		$"../AcceptTextBox".visible = false
		can_pass_to_next_dialog = false
		
		if page == dialog.size() - 1:
			end_dialog()
			return
		
		if page < dialog.size() - 1:
			page += 1
			set_bbcode(dialog[page])
			set_visible_characters(0)
			$"../Timer".start()

func _on_Timer_timeout():
	if get_visible_characters() > get_total_character_count():
		$"../Timer".stop()
		$"../TimerToShowAccept".start()
	else:
		if not audio_player.is_playing():
			audio_player.stream = voice_sound
			audio_player.play()
			
		set_visible_characters(get_visible_characters()+1)
	
func set_visible(flag: bool):
	get_owner().visible = flag
	
func start_dialog(dialogs):
	dialog_ended = false
	dialog = dialogs
	page = 0
	set_bbcode(dialog[page])
	set_visible_characters(0)
	set_process_input(true)
	set_visible(true)
	$"../Timer".start()

func end_dialog():
	$"../TimerToShowAccept".stop()
	$"../Timer".stop()
	set_visible(false)
	dialog_ended = true
	BackgroundMusic.play()

func _on_TimerToShowAccept_timeout():
	$"../TimerToShowAccept".stop()
	$"../AcceptTextBox".visible = true
	can_pass_to_next_dialog = true
