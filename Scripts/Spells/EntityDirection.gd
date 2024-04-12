class_name EntityDirection

extends Spell

var entity

func _init():
	spell_name = "Entity Direction"
	cost = 0
	unlocked_by_default = true
	variables = {"entity" : "Entity"}
	pattern = ["r", "r", "dur"]
	description = "Returns the direction of the entity inputted."
	category = SpellCategory.Scouting

func spell_effect():
	if entity != null:
		returns.append(StackItem.new(entity.value.head.get_node("Camera3D").get_global_transform().basis.z * -1))
	return returns 
