class_name SummonLight

extends Spell

var light_pos
var light_scene = preload("res://Scenes/ArcaneLight.tscn")

func _init():
	spell_name = "Addition"
	cost = 0
	variables = {"light_pos" : "Vector3"}
	unlocked_by_default = true

func spell_effect():
	if light_pos != null:
		var instance = light_scene.instantiate()
		Global.current_scene.root.add_child(instance)
		instance.position = light_pos.value
	return returns 
