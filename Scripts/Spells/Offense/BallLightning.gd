class_name BallLightning

extends RuneSpell

var projectile : PackedScene = load("res://Scenes/SpellPrefabs/ball_of_lightning.tscn")

func _init():
	spell_name = "Ball Lightning"
	pattern = [ElectricRune.new(), ProjectileRune.new(), RadialRune.new()]
	
func spell_effect():
	var instance : LightningBallProjectile = projectile.instantiate()
	instance.position = caster.head.global_position
	
	Global.current_scene.add_child(instance)
	instance.look_at(instance.position + caster.get_direction())
