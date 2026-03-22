class_name Pickup extends Area2D

@export var disappears: bool = false

func _ready() -> void:
	connect("body_entered", Callable(self, "body_entered"))
	connect("area_entered", Callable(self, "area_entered"))

func area_entered(area: Node2D) -> void:
	var area_parent = area.get_parent()
	if area_parent.name == "sword":
		get_node(self.get_path()).body_entered(area_parent.get_parent())
