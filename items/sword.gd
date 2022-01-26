extends Node2D

var type: String = ''
var maxamount: int = 1
	
func set_texture(texture):
	$Position2D/Sprite.texture = texture
	
func _ready() -> void:
	type = get_parent().type
	get_parent().set_sword_invisible()
	$anim.connect("animation_finished", self, 'destroy')
	$anim.play(str('swing', get_parent().sprite_direction))
	if get_parent().has_method('state_swing'):
		get_parent().state = 'swing'
		

func destroy(_animation) -> void:
	if get_parent().has_method('state_swing'):
		get_parent().state = 'default'
	get_parent().set_sword_visible()
	queue_free()
	
	

func get_fire_state():
	return get_parent().sword_on_fire
	
func catch_fire():
	get_parent().wood_catch_fire()


func _on_Area2D_area_entered(area):
	if area.name != "Vision":
		var partent = area.get_parent()
		if partent.has_method("hurt"):
			partent.hurt(self)
