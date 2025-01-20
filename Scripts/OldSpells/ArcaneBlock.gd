class_name ArcaneBlock

extends Spell

var block_pos : StackItem
var block_scene = preload("res://Scenes/ArcaneBlock.tscn")

func _init():
	spell_name = "Arcane Block"
	cost = 0
	variables = {"block_pos" : "Vector3"}
	pattern = ["u", "r", "d", "l", "dur"]
	description = "Summon an arcane block at the given position."
	category = SpellCategory.Conjuration

func spell_effect():
	if block_pos != null and block_pos.value is Vector3:
		var instance = block_scene.instantiate()
		Global.current_scene.add_child(instance)
		instance.position = block_pos.value
	else:
		returns.append(StackItem.new(0))
	return returns 
