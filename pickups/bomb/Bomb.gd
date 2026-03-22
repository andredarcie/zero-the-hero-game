extends Node2D

var exploded := false
var damage := 1
var type := "explosion"


func _on_Timer_timeout():
	if exploded:
		return
	exploded = true
	_play_explosion()
	

func spread_the_blast_damage():
	for body in $Range.get_overlapping_bodies():
		if body.has_method("make_damage"):
			body.make_damage(self)
		if body.has_method("hurt"):
			body.hurt(self)
			
	for area in $Range.get_overlapping_areas():
		var parent = area.get_parent()
		if parent.has_method("catch_fire"):
			parent.catch_fire()
		elif area.has_method("toggle_switch"):
			area.toggle_switch()
	
	
func destroy():
	queue_free()


func _play_explosion() -> void:
	spread_the_blast_damage()
	$AnimationPlayer.stop()
	$Sprite2D.frame = 1
	$Sprite2D.modulate = Color(1, 0.95, 0.75, 1)
	$Sprite2D.scale = Vector2(0.65, 0.65)
	$Shockwave.visible = true
	$Shockwave.modulate = Color(1, 0.9, 0.65, 0.9)
	$Shockwave.scale = Vector2(0.45, 0.45)
	for node_name in ["CrossUp", "CrossDown", "CrossLeft", "CrossRight"]:
		var node := get_node(node_name) as Sprite2D
		node.visible = true
		node.modulate = Color(1, 0.88, 0.5, 0.9)
		node.scale = Vector2(0.32, 0.32)
	$ExplosionParticles.visible = true
	$ExplosionParticles.restart()
	$ExplosionParticles.emitting = true

	var tween := create_tween()
	tween.set_parallel(true)
	tween.tween_property($Sprite2D, "scale", Vector2(1.8, 1.8), 0.09).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property($Sprite2D, "modulate", Color(1, 0.58, 0.12, 0.0), 0.14).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.tween_property($Shockwave, "scale", Vector2(0.95, 0.95), 0.12).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
	tween.tween_property($Shockwave, "modulate", Color(1, 0.82, 0.28, 0.0), 0.12).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	for node_name in ["CrossUp", "CrossDown", "CrossLeft", "CrossRight"]:
		var cross := get_node(node_name) as Sprite2D
		tween.tween_property(cross, "scale", Vector2(0.7, 0.7), 0.11).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
		tween.tween_property(cross, "modulate", Color(1, 0.82, 0.3, 0.0), 0.11).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
	tween.chain().tween_interval(0.05)
	tween.chain().tween_callback(destroy)
