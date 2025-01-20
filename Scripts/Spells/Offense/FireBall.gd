class_name FireBallSpell

extends RuneSpell

var projectile : PackedScene = load("res://Scenes/SpellPrefabs/Bolt.tscn")

func _init():
	spell_name = "Fire Ball"
	pattern = [FireRune.new().rune_name, ProjectileRune.new().rune_name]
	
func spell_effect():
	var instance : BoltProjectile = projectile.instantiate()
	instance.position = caster.head.global_position
	
	Global.current_scene.add_child(instance)
	instance.look_at(instance.position + caster.get_direction())
