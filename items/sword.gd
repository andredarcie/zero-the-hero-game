extends Node2D

const SWING_DURATION := 0.16
const RECOVERY_DURATION := 0.06
const ANTICIPATION_DURATION := 0.04

const SWING_CONFIG := {
	"down": {
		"position": Vector2(0, 10),
		"rotation_degrees": 180.0,
		"z_index": 1,
		"start_angle": -130.0,
		"anticipation_angle": -155.0,
		"slash_angle": 88.0
	},
	"left": {
		"position": Vector2(-10, 3),
		"rotation_degrees": 270.0,
		"z_index": 1,
		"start_angle": -120.0,
		"anticipation_angle": -145.0,
		"slash_angle": 92.0
	},
	"right": {
		"position": Vector2(10, 3),
		"rotation_degrees": 90.0,
		"z_index": 1,
		"start_angle": -120.0,
		"anticipation_angle": -145.0,
		"slash_angle": 92.0
	},
	"up": {
		"position": Vector2(0, -10),
		"rotation_degrees": 0.0,
		"z_index": -1,
		"start_angle": -120.0,
		"anticipation_angle": -145.0,
		"slash_angle": 82.0
	}
}

var type: String = ""
var maxamount: int = 1

@onready var marker := $Marker2D
@onready var sprite := $Marker2D/Sprite2D
@onready var hitbox := $Marker2D/Sprite2D/sword


func set_texture(texture) -> void:
	var target_sprite := sprite if sprite != null else get_node_or_null("Marker2D/Sprite2D")
	if target_sprite != null:
		target_sprite.texture = texture


func _ready() -> void:
	type = get_parent().type
	get_parent().set_sword_invisible()
	if get_parent().has_method("state_swing"):
		get_parent().state = "swing"

	_play_swing(get_parent().sprite_direction)


func _play_swing(direction: String) -> void:
	var config: Dictionary = SWING_CONFIG.get(direction, SWING_CONFIG["down"])
	position = config["position"]
	rotation_degrees = config["rotation_degrees"]
	z_index = config["z_index"]

	sprite.frame = 0
	sprite.scale = Vector2.ONE
	marker.rotation_degrees = config["start_angle"]
	hitbox.monitoring = false

	var tween := create_tween()
	tween.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	tween.tween_property(marker, "rotation_degrees", config["anticipation_angle"], ANTICIPATION_DURATION).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(sprite, "scale", Vector2(0.92, 1.08), ANTICIPATION_DURATION).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_callback(func() -> void:
		hitbox.monitoring = true
		sprite.scale = Vector2(1.12, 0.9)
	)
	tween.tween_property(marker, "rotation_degrees", config["slash_angle"], SWING_DURATION).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(sprite, "scale", Vector2(1.0, 1.0), SWING_DURATION).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	tween.tween_callback(func() -> void:
		hitbox.monitoring = false
	)
	tween.tween_property(marker, "rotation_degrees", config["slash_angle"] - 10.0, RECOVERY_DURATION).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.finished.connect(_finish_swing)


func _finish_swing() -> void:
	if get_parent().has_method("state_swing"):
		get_parent().state = "default"
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
