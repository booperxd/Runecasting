class_name Bolt

extends Spell

var starting_position : StackItem
var direction : StackItem

var projectile : PackedScene = load("res://Scenes/SpellPrefabs/Bolt.tscn")

func _init():
	spell_name = "Bolt"
	description = "Shoot a bolt of arcane energy, starting from the first vector\
	\nand shot in the direction of the second vector passed (direction vector)."
	category = SpellCategory.Projectile
	variables = {"starting_position" : "Vector3", "direction" : "Vector3"}
	pattern = ["ddr", "r", "dur", "dul", "l", "ddl"]

func spell_effect():
	if starting_position.value is Vector3 and direction.value is Vector3:
		var instance : Area3D = projectile.instantiate()
		instance.position = starting_position.value
		
		Global.current_scene.add_child(instance)
		instance.look_at(instance.position + direction.value)
	return returns
