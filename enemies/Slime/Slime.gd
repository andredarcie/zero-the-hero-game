class_name Slime extends Enemy

onready var FootSteps = preload("res://enemies/Slime/SlimeFootSteps.tscn")
onready var SlimePool: PackedScene  = preload("res://enemies/Slime/SlimePool.tscn")

func _ready():
	self.PoolOfBlood = SlimePool
	speed = 60
	$ChangeMovimentDirection.wait_time = 0
	$Sprite.rotation_degrees = 0
	$EnemyAnimationPlayer.queue_free()
		

func _on_Timer_timeout():
	var foot_steps = FootSteps.instance()
	foot_steps.global_position = global_position
	get_parent().add_child(foot_steps)
