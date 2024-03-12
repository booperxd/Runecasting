class_name Multiply

extends Spell

var x
var y

func _init():
	spell_name = "Multiply"
	cost = 0
	unlocked_by_default = true
	variables = {"x" : "int/vector", "y" : "int/vector"}

func spell_effect():
	if x != null and y != null:
		returns.append(StackItem.new(x.value * y.value))
	return returns 
