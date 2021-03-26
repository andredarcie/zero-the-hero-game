class_name Watchman extends Enemy

var saw_the_player: bool = false
var debug_mode: bool = true

func _ready():
	move_random_direction = false
	$Sprite2.frame = 0
	
	if not debug_mode:
		turn_off_debug_mode()
	
func _physics_process(delta):	
	var saw_the_player_1 = check_raycast_collission($Vision)
	var saw_the_player_2 = check_raycast_collission($Vision2)
	var saw_the_player_3 = check_raycast_collission($Vision3)
	var saw_the_player_4 = check_raycast_collission($Vision4)	
	var saw_the_player_5 = check_raycast_collission($Vision5)
	var saw_the_player_6 = check_raycast_collission($Vision5)	
	var saw_the_player_7 = check_raycast_collission($Vision7)
		
	if saw_the_player_1 or saw_the_player_2 or saw_the_player_3 or saw_the_player_4 or saw_the_player_5 or saw_the_player_6 or saw_the_player_7:
		$Sprite2.frame = 1
	else:
		$Sprite2.frame = 0


func check_raycast_collission(ray_cast : RayCast2D):
	if ray_cast.get_collider():
		if GameState.check_body_is_player(ray_cast.get_collider()):
			return true
		else:
			return false
	else:
		return false


func turn_off_debug_mode():
	for child in self.get_children():
		if 'Vision' in child.name:
			for sub_child in child.get_children():
				sub_child.queue_free()
