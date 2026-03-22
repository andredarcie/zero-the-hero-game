class_name Watchman extends Enemy

var player = null
const FOV_TOLERANCE = 25
const MAX_DETECTION_RANGE = 60

func _ready():
	player = get_node("/root").find_child("Player", true, false)
	move_random_direction = false
	$Sprite2.frame = 0
	
func _physics_process(_delta):	
	if player_in_field_of_view() and player_line_of_sight():
		$Sprite2.frame = 1
	else:
		$Sprite2.frame = 0

func player_in_field_of_view() -> bool:
	var npc_facing_direction = Vector2.DOWN.rotated(global_rotation)
	var direction_to_player = (player.global_position - global_position).normalized()
	
	return abs(direction_to_player.angle_to(npc_facing_direction)) < deg_to_rad(FOV_TOLERANCE)

func player_line_of_sight() -> bool:
	var space = get_world_2d().direct_space_state
	var query := PhysicsRayQueryParameters2D.create(global_position, player.global_position, collision_mask, [get_rid()])
	query.collide_with_bodies = true
	query.collide_with_areas = false
	var LOS_obstacle := space.intersect_ray(query)
	
	if LOS_obstacle.is_empty():
		return false
	
	var distance_to_player = player.global_position.distance_to(global_position)
	var Player_in_Range = distance_to_player < MAX_DETECTION_RANGE
	
	return LOS_obstacle.collider == player and Player_in_Range
