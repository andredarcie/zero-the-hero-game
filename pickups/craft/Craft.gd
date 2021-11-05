extends Node2D

var wood = 1
enum ThingToBuild {Bonfire, Bridge}
export(ThingToBuild) var thing_to_build
var builded: bool = false

func _ready():
	match thing_to_build:
		ThingToBuild.Bonfire:
			$Water.queue_free()
			$Bonfire/CollisionShape2D.call_deferred("set", "disabled", true)
			$Bonfire.visible = true
			$Bonfire/AnimatedSprite.visible = false
			$Bonfire/Base.visible = true
			$Bonfire/Light2D.visible = false
			
			if GameState.create_check(self):
				build_bonfire()
			
		ThingToBuild.Bridge:
			$Water.visible = true			
			$Bonfire.queue_free()
			
			if GameState.create_check(self):
				build_bridge()


func _process(delta):
	if builded:
		return
		
	if GameState.player_wood >= wood:
		$Area2D/Sprite.modulate.a = 255

func _on_Area2D_body_entered(body):
	if GameState.check_body_is_player(body):
		if GameState.player_wood >= wood:
			GameState.player_wood = GameState.player_wood - wood
			
			match thing_to_build:
				ThingToBuild.Bonfire:
					build_bonfire()
					SoundEffects.play_switch_sound()
				ThingToBuild.Bridge:
					build_bridge()
					SoundEffects.play_bridge_sound()
					
			GameState.destroy(self)
		else:
			var player = GameState.get_player()
			player.show_ballon_wood()
		

func build_bonfire():
	$Area2D.queue_free()
	$Bonfire/CollisionShape2D.call_deferred("set", "disabled", false)
	$Bonfire/AnimatedSprite.visible = true
	$Bonfire/Base.visible = false
	$Bonfire/Light2D.visible = true
	builded = true

func build_bridge():
	$Area2D.queue_free()
	$BridgeArea2D/Sprite.visible = true
	$Water/StaticBody2D.queue_free()
	builded = true

func _on_Area2D_body_exited(body):
	if GameState.check_body_is_player(body):
		var player = GameState.get_player()
		player.hide_ballon_wood()
