class_name Flip 

extends Spell

var x
var y

func _init():
	spell_name = "Flip"
	cost = 0
	variables = {"x" : "StackItem", "y" : "StackItem"}

func spell_effect():
	if x != null and y != null:
		returns.append(x)
		returns.append(y)
	return returns 
