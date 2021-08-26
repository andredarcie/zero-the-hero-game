extends ColorRect
	
func _ready():
	var tween = $Tween
	tween.interpolate_property(get_material(), "shader_param/progress", 1, 0, 1, Tween.TRANS_CUBIC, Tween.EASE_OUT) 
	tween.start()
