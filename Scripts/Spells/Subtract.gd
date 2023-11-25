class_name Subtract

extends Spell

var x
var y

func _init():
	spell_name = "Subtract"
	cost = 0
	variables = {"x" : "int", "y" : "int"}

func spell_effect():
	if x != null and y != null:
		returns.append(StackItem.new(x.value - y.value))
	return returns
