extends ColorRect
	
func _ready():
	var material := get_material()
	material.set_shader_parameter("progress", 1.0)

	var tween := create_tween()
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(material, "shader_parameter/progress", 0.0, 1.0)
