class_name BigSlime extends Enemy

onready var FootSteps = preload("res://enemies/BigSlime/BigSlimeFootSteps.tscn")
onready var SlimePool: PackedScene  = preload("res://enemies/BigSlime/BigSlimePool.tscn")
onready var Slime: PackedScene  = preload("res://enemies/Slime/Slime.tscn")

func _ready():
	self.sprite_hurt = preload("res://enemies/BigSlime/BigSlime.png")
	self.PoolOfBlood = SlimePool
	speed = 25
	$ChangeMovimentDirection.wait_time = 4
	$Sprite.rotation_degrees = 0
	$EnemyAnimationPlayer.queue_free()
		

func _on_Timer_timeout():
	var foot_steps = FootSteps.instance()
	foot_steps.global_position = global_position
	get_parent().add_child(foot_steps)
	
func _process(delta):
	if self.enemy_is_dead:
		var slime_1 = Slime.instance()
		var slime_2 = Slime.instance()
		slime_1.global_position = global_position
		slime_2.global_position = global_position
		get_parent().add_child(slime_1)
		get_parent().add_child(slime_2)
