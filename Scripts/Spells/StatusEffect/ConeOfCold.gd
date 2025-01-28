class_name ConeOfCold

extends RuneSpell

var frost_sphere_scene : PackedScene = load("res://Scenes/SpellPrefabs/frost_radius.tscn")

func _init():
	spell_name = "Cone of Cold"
	pattern = [FrostRune.new(), RadialRune.new(),  FrostRune.new()]

func spell_effect():
	var frost_instance = frost_sphere_scene.instantiate()
	
	Global.current_scene.add_child(frost_instance)
	frost_instance.position = caster.head.global_position
