class_name LobSpell

extends Spell

var projectile : PackedScene = load("res://Scenes/SpellPrefabs/LobProjectile.tscn")
var element : Element

func _init():
	spell_name = "Lob"
	description = "Lob arcane energy in the form of a dense ball of whatever element selected. Ball is affected by gravity. Ball explodes when it collides on something."
	category = SpellCategory.Projectile
	variables = {"element" : "Element"}
	pattern = ["r", "ddr", "ddl", "ddr", "dur", "dul"]

func spell_effect():
	var pos : Vector3 = caster.head.get_global_position()
	var dir : Vector3 = caster.head.get_node("Camera3D").get_global_transform().basis.z * -1
	
	var instance : LobProjectile = projectile.instantiate()
	
	
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
