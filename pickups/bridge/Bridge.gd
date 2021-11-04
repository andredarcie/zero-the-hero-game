extends Node2D

var wood = 5
enum ThingToBuild {Bonfire, Dridge}
export(ThingToBuild) var thing_to_build

func _ready():
	match thing_to_build:
		ThingToBuild.Bonfire:
			$Bonfire/CollisionShape2D.call_deferred("set", "disabled", true)
			$Bonfire.visible = true
			$Bonfire/AnimatedSprite.visible = false
			$Bonfire/Base.visible = true
			$Bonfire/Light2D.visible = false

func _process(delta):
	if GameState.player_wood >= wood:
		$Area2D/Sprite.modulate.a = 255

func _on_Area2D_body_entered(body):
	if GameState.check_body_is_player(body):
		if GameState.player_wood >= wood:
			GameState.player_wood = GameState.player_wood - wood
		
			$Area2D.queue_free()
			
			match thing_to_build:
				ThingToBuild.Bonfire:
					$Bonfire/CollisionShape2D.call_deferred("set", "disabled", false)
					$Bonfire/AnimatedSprite.visible = true
					$Bonfire/Base.visible = false
					$Bonfire/Light2D.visible = true
					SoundEffects.play_switch_sound()
				ThingToBuild.Dridge:
					$BridgeArea2D/Sprite.visible = true
					for _i in $BridgeArea2D.get_overlapping_bodies():
						var staticBody2D = _i.get_parent().get_node("StaticBody2D")
						if staticBody2D:
							staticBody2D.queue_free()
					
					SoundEffects.play_bridge_sound()
			
		else:
			var player = GameState.get_player()
			player.show_ballon_wood()
		


func _on_Area2D_body_exited(body):
	if GameState.check_body_is_player(body):
		var player = GameState.get_player()
		player.hide_ballon_wood()
