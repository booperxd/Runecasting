class_name EntityPosition

extends Spell

var entity

func _init():
	spell_name = "Entity Position"
	cost = 0
	variables = {"entity" : "Entity"}

func spell_effect():
	if entity != null:
		returns.append(StackItem.new(entity.value.get_global_position()))
	return returns 
