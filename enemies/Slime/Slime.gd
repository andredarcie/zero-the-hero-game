class_name Slime extends Enemy

func _ready():
	$ChangeMovimentDirection.wait_time = 4
	$Sprite.rotation_degrees = 0
	$EnemyAnimationPlayer.queue_free()
