extends Path2D

onready var Follow = $PathFollow2D

func _ready():
	set_process(true)
	
func _process(delta):
	Follow.set_offset(Follow.get_offset() + 25 * delta)
