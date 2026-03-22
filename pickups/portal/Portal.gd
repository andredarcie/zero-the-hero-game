class_name Portal extends Area2D

var base_position := Vector2.ZERO
var base_scale := Vector2.ONE
var t := 0.0

func _ready():
	visible = false
	base_position = position
	base_scale = scale
	$AnimatedSprite2D.play("default")
	
func _process(delta):
	t += delta
	var drift := sin(t * 3.2) * 1.6
	position = base_position + Vector2(0, drift)
	scale = base_scale * (1.0 + sin(t * 5.4) * 0.035)
	$Glow.energy = 1.15 + (sin(t * 6.5) + 1.0) * 0.22
	$Particles.amount_ratio = 0.65 + (sin(t * 4.8) + 1.0) * 0.175

	if GameState.player_current_item_is_sword():
		visible = true
	else:
		visible = false
		
func _on_Portal_body_entered(body):
	if GameState.check_body_is_player(body) and visible:
		LevelManager.go_to_next_level()		
