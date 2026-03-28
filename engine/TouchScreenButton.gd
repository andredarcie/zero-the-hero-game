extends TouchScreenButton

var boundary: float = 64.0
var threshold: float = 10.0
var return_speed: float = 20.0

var ongoing_drag: int = -1
var joystick_origin: Vector2 = Vector2.ZERO
var handle_offset: Vector2 = Vector2.ZERO
var original_parent_pos: Vector2

func _ready() -> void:
	original_parent_pos = get_parent().position

func _process(delta: float) -> void:
	if ongoing_drag == -1 and handle_offset.length() > 0.5:
		handle_offset = handle_offset.lerp(Vector2.ZERO, return_speed * delta)
		global_position = get_parent().global_position + handle_offset

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.is_pressed() and ongoing_drag == -1:
			var half_screen = get_viewport().get_visible_rect().size.x / 2.0
			if event.position.x < half_screen:
				joystick_origin = event.position
				handle_offset = Vector2.ZERO
				get_parent().global_position = event.position
				global_position = event.position
				ongoing_drag = event.get_index()
		elif not event.is_pressed() and event.get_index() == ongoing_drag:
			ongoing_drag = -1
			get_parent().position = original_parent_pos

	if event is InputEventScreenDrag and event.get_index() == ongoing_drag:
		var delta_pos = event.position - joystick_origin
		if delta_pos.length() > boundary:
			delta_pos = delta_pos.normalized() * boundary
		handle_offset = delta_pos
		global_position = joystick_origin + handle_offset

func get_value() -> Vector2:
	if ongoing_drag != -1 and handle_offset.length() > threshold:
		return handle_offset.normalized()
	return Vector2.ZERO
