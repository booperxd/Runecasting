class_name IceBolt

extends RuneSpell

var projectile : PackedScene = load("res://Scenes/SpellPrefabs/ice_bolt.tscn")

func _init():
	spell_name = "Ice Bolt"
	pattern = [FrostRune.new().rune_name, ProjectileRune.new().rune_name]
	
func spell_effect():
	var instance : IceBoltProjectile = projectile.instantiate()
	instance.position = caster.head.global_position
	
	Global.current_scene.add_child(instance)
	instance.look_at(instance.position + caster.get_direction())
