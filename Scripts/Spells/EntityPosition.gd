class_name EntityPosition

extends Spell

var entity

func _init():
	spell_name = "Entity Position"
	cost = 0
	unlocked_by_default = true
	variables = {"entity" : "Entity"}
	pattern = ["r", "r", "ddr"]
	description = "Returns the position of the entity inputted."
	category = SpellCategory.Scouting

func spell_effect():
	if entity != null:
		returns.append(StackItem.new(entity.value.get_global_position()))
	return returns 
