extends CanvasLayer

var start_pos: Vector2 = Vector2.ZERO
var end_pos: Vector2 = Vector2.ZERO
var valid_pos = false

@onready var js_pos = get_node("background").position
@onready var js_bg = get_node("background")
@onready var js_handle = get_node("background/handle")

signal swipe_detect(swipe_direction, strength)
signal swipe_end

func _input(event: InputEvent) -> void:

	if valid_pos:
		if event is InputEventScreenDrag:
			if start_pos == Vector2.ZERO:
				start_pos = event.position
				js_bg.position = Vector2(start_pos.x - 128, start_pos.y - 128)

			end_pos = event.position
			var direction = end_pos - start_pos
			if direction.length() < 120:
				js_handle.position.x = 96 + direction.length()
				js_handle.pivot_offset.x = 32 - direction.length()

			js_handle.rotation = rad_to_deg(direction.angle())
			emit_signal("swipe_detect",direction, direction.length())



func _on_TextureButton_button_down() -> void:
	valid_pos = true



func _on_TextureButton_button_up() -> void:
	emit_signal("swipe_end")
	js_bg.position = js_pos
	start_pos = Vector2.ZERO
	end_pos = Vector2.ZERO
	valid_pos = false
	js_handle.position.x = 96
	js_handle.pivot_offset.x = 32
