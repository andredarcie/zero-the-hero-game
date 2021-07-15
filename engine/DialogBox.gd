class_name DialogBox extends Polygon2D	
	
func start_dialog(name: String, dialogs):
	BackgroundMusic.stop()
	$TextName.set_name(name + ': ')
	$TextBox.start_dialog(dialogs)
	$AcceptTextBox.visible = false
	
func is_dialog_ended():
	return $TextBox.dialog_ended

func end_dialog():
	BackgroundMusic.play()
	$TextBox.end_dialog()
