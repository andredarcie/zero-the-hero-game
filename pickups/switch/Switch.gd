class_name Switch extends Area2D

var proximity: bool = false
var active: bool = false
var await_time: float = 0
var objects = []

var on_image: Texture = preload("res://pickups/switch/on.png")
var off_image: Texture = preload("res://pickups/switch/off.png")

func _ready() -> void:
	self.objects = get_children()
	
func _on_switch_body_entered(body: Node2D) -> void:
	if body.get("type") == "player":
		self.proximity = true

func _on_switch_body_exited(body: Node2D) -> void:
	if body.get("type") == "player":
		self.proximity = false
	
func _process(_delta: float) -> void:	
	if self.await_time > 0:
		self.await_time = self.await_time - 1
	
	var key_press: bool = Input.is_action_pressed("ui_accept")
	if await_time == 0 && key_press && self.proximity:
		toggle_switch()

func toggle_switch():
	self.active = !self.active
	if self.active:
		$Sprite.texture = on_image
	else:
		$Sprite.texture = off_image
		
	SoundEffects.play_switch_sound()
	self.set_all_objects()
	self.await_time = 10
	

func set_all_objects():
	for object in self.objects:
		print(object.name)
		if object.has_method("toggle"):
			object.toggle()


func _on_Switch_area_entered(area):
	if area.get_parent().name == "sword":
		toggle_switch()
