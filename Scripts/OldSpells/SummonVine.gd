class_name SummonVine

extends Spell

var vine_pos : StackItem
var vine_prefab : PackedScene = preload("res://Scenes/SpellPrefabs/Vine.tscn")

func _init():
	spell_name = "Summon Vine"
	cost = 0
	variables = {"vine_pos" : "Vector3"}
	unlocked_by_default = true
	pattern = ["u", "ddl", "dul", "dur", "ddr", "ddr", "dur", "dul",  "ddl"]
	description = "Rapidly grow a climbable vine at the given position. If the position is not on the ground, it will attempt to grow on the nearest floor below (if it exists)"
	category = SpellCategory.Conjuration

func spell_effect():
	if vine_pos != null and vine_pos.value is Vector3:
		var instance : VineObject = vine_prefab.instantiate()
		Global.current_scene.add_child(instance)
		instance.position = vine_pos.value + Vector3(0.0, 6.0, 0.0)
		#else:
		#	Global.current_scene.remove_child(instance)
	return returns
