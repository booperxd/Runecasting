class_name ArcaneBlock

extends Spell

var block_pos
var block_scene = preload("res://Scenes/ArcaneBlock.tscn")

func _init():
	spell_name = "Arcane Block"
	cost = 0
	variables = {"block_pos" : "Vector3"}

func spell_effect():
	if block_pos != null:
		var instance = block_scene.instantiate()
		Global.current_scene.root.add_child(instance)
		instance.position = block_pos.value
	return returns 
