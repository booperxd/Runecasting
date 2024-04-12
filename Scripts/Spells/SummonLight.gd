class_name SummonLight

extends Spell

var light_pos
var light_scene = preload("res://Scenes/ArcaneLight.tscn")

func _init():
	spell_name = "Summon Light"
	cost = 0
	variables = {"light_pos" : "Vector3"}
	unlocked_by_default = true
	pattern = ["dur", "dul", "l", "dur"]
	description = "Summon a glowing, arcane light at the given position."
	category = SpellCategory.Conjuration

func spell_effect():
	if light_pos != null:
		var instance = light_scene.instantiate()
		Global.current_scene.add_child(instance)
		instance.position = light_pos.value
	return returns 
