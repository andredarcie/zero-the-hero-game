extends Node2D

var input1: bool = false
var input2: bool = false
var output: bool = false

func _ready():
	add_to_group("LogicGate")
	
func toggle_input(name: String) -> void:
	if name == "Input1":
		input1 = !input1
	elif name == "Input2":
		input2 = !input2
	
	output = input1 and input2
		
	if output:
		$Sprite2D.frame = 1
		for child in $Output.get_overlapping_areas():
			var parent =  child.get_parent()
			if parent.is_in_group("Wire") and parent.has_method("on"):
					parent.on("Up")
					return
	else:
		$Sprite2D.frame = 0
		for child in $Output.get_overlapping_areas():
			var parent =  child.get_parent()
			if parent.is_in_group("Wire") and parent.has_method("off"):
					parent.off("Up")
					return



