extends Area2D

var rng = RandomNumberGenerator.new()
onready var coin = preload("res://pickups/coin/Coin.tscn")
onready var vase_sound = preload("res://pickups/vase/vase_sound.mp3")
var broken: bool = false

func _ready():
	GameState.create(self)

func _on_Vase_area_entered(area):
	if not broken:
		var parent = area.get_parent()
		if parent.name == "sword":
			rng.randomize()
			var my_random_number = rng.randi_range(0, 1)
			
			if my_random_number == 1:
				var new_coin = coin.instance()
				new_coin.position = global_position
				get_tree().root.get_child(2).add_child(new_coin)
				
				
			$AnimatedSprite.play("breaking")
			SoundEffects.play_sound(vase_sound)
			$StaticBody2D.queue_free()
			broken = true
			
			GameState.destroy(self)
