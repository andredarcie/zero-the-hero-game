extends Area2D

var active: bool = true
var damage = 1

func _ready():
	add_to_group("UpDownBlock")
	
	if self.active:
		turn_active()
	else:
		turn_desactive()


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
	print('chamou', self.active)
	self.active = !self.active
	
	if self.active:
		turn_active()
	else:
		turn_desactive()
