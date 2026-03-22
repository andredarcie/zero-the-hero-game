class_name Switch extends Area2D

var active: bool = false
var objects = []
@export var switch_name = ""

var on_image: Texture2D = preload("res://pickups/switch/on.png")
var off_image: Texture2D = preload("res://pickups/switch/off.png")

func _ready() -> void:
	self.objects = get_children()
	
	if GameState.create_check(self):
		toggle_switch()

func toggle_switch():
	self.active = !self.active
	
	if self.active:
		$Sprite2D.texture = on_image
		GameState.destroy(self)
	else:
		$Sprite2D.texture = off_image
		
	self.set_all_objects()
	

func set_all_objects():
	for object in self.objects:
		print(object.name)
		if object.has_method("toggle"):
			object.toggle()


func _on_Switch_area_entered(area):
	if area.get_name() == "sword":
		toggle_switch()
		SoundEffects.play_switch_sound()
