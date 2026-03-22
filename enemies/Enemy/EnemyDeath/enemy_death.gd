extends Node2D

func _ready() -> void:
	$anim.play("default")
	$anim.connect("animation_finished", Callable(self, "destroy"))

func destroy() -> void:
	queue_free()
