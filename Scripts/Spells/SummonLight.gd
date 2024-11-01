class_name SummonLight

extends Spell

var light_owner : StackItem
var light_scene = preload("res://Scenes/ArcaneLight.tscn")

func _init():
	spell_name = "Summon Mage Light"
	cost = 0
	variables = {"light_owner" : "Being"}
	unlocked_by_default = true
	pattern = ["dur", "dul", "l", "dur"]
	description = "Attaches a glowing sphere to an entity that lasts for 30 seconds"
	category = SpellCategory.Conjuration

func spell_effect():
	if light_owner != null and light_owner.value is Being:
		var instance = light_scene.instantiate()
		light_owner.value.add_child(instance)
		instance.position = light_owner.value.position + Vector3(0, 1, 0)
	return returns 
