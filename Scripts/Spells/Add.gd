class_name Add

extends Spell

var x
var y

func _init():
	spell_name = "Addition"
	cost = 0
	unlocked_by_default = true
	pattern = ["l", "ddr", "ddl", "r"]
	description = "Removes two elements from the stack and adds the sum to the queue."
	variables = {"x" : "int/vector", "y" : "int/vector"}
	category = SpellCategory.Math

func spell_effect():
	if x != null and y != null:
		returns.append(StackItem.new(x.value + y.value))
	else:
		returns.append(StackItem.new(0))
	return returns 
