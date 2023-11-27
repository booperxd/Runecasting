class_name Add

extends Spell

var x
var y

func _init():
	spell_name = "Addition"
	cost = 0
	variables = {"x" : "int/vector", "y" : "int/vector"}

func spell_effect():
	if x != null and y != null:
		returns.append(StackItem.new(x.value + y.value))
	return returns 
