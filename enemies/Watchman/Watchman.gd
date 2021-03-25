class_name Watchman extends Enemy

func _ready():
	move_random_direction = false
	$Sprite2.frame = 0
	
func _physics_process(delta):	
	if $Vision.get_collider():
		if GameState.check_body_is_player($Vision.get_collider()):
			$Sprite2.frame = 1
		else:
			$Sprite2.frame = 0
	else:
		$Sprite2.frame = 0
