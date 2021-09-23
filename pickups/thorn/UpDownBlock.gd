extends Area2D

var active: bool = true
var damage = 1
export var switch_name = ""

func _ready():
	add_to_group("UpDownBlock")
	
	if self.active:
		turn_active()
	else:
		turn_desactive()

func _process(delta):
	pass
	#if self.active == GameState[switch_name]:
	#	return
		
	#if GameState[switch_name]:
	#	self.active = true
	#	turn_active()
	#else:
	#	self.active = false
	#	turn_desactive()

func turn_active():
	$Sprite.frame = 0
	$CollisionShape2D.set_deferred("disabled", false)
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", false)
	$DamageArea/CollisionShape2D.set_deferred("disabled", false)
	
	
func turn_desactive():
	$Sprite.frame = 1
	$CollisionShape2D.set_deferred("disabled", true)
	$StaticBody2D/CollisionShape2D.set_deferred("disabled", true)
	$DamageArea/CollisionShape2D.set_deferred("disabled", true)
	

func toggle():
	self.active = !self.active
	
	if self.active:
		turn_active()
	else:
		turn_desactive()
