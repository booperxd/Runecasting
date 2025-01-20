class_name Explosion

extends Spell

var explosion_prefab : PackedScene = preload("res://Scenes/SpellPrefabs/Explosion.tscn")
var position : StackItem
var strength : StackItem


func _init():
	spell_name = "Explosion"
	description = "Summon an explosion at the given position, given an int indicating its strength (ranging from 1 - 10).
	\n If the explosion is greater than 4, it will damage the environment. Does not discriminate in who or what it damages."
	category = SpellCategory.Conjuration
	pattern = ["dur", "u", "dul", "dur", "r", "ddr", "ddl", "d", "ddr"]
	variables = {"position" : "Vector3", "strength": "int"}

func spell_effect():
	if position != null and position.value is Vector3 and strength != null and strength.value is int:
		var instance : ExplosionEffect = explosion_prefab.instantiate()
		instance.position = position.value
		instance.strength = strength.value
		Global.current_scene.add_child(instance)
	return returns
