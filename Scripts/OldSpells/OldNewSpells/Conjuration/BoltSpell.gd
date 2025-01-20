class_name BoltSpell

extends Spell

var projectile : PackedScene = load("res://Scenes/SpellPrefabs/Bolt.tscn")
var element : Element

func _init():
	spell_name = "Bolt"
	description = "Shoot a bolt of a desired element. Will do less damage but travels very quickly."
	category = SpellCategory.Projectile
	variables = {"element" : Element.new()}
	pattern = ["ddr", "r", "dur", "dul", "l", "ddl"]


func spell_effect():
	var pos : Vector3 = caster.head.get_global_position()
	var dir : Vector3 = caster.head.get_node("Camera3D").get_global_transform().basis.z * -1
	
	var instance : BoltProjectile = projectile.instantiate()
	
	
	instance.position = pos
	
	if (element != null):
		instance.element = element
	else:
		instance.element = null
	instance.setup_projectile(1, 1, 1)
	for modifier in modifiers:
		if modifier is Modifier:
			instance.setup_projectile(modifier.scale_modifier, modifier.speed_modifier, modifier.damage_modifier)
	modifiers.clear()
	
	Global.current_scene.add_child(instance)
	instance.look_at(instance.position + dir)
	
	Global.finale_spell_casted.emit()
	return returns
