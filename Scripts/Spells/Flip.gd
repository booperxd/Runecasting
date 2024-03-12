class_name Flip 

extends Spell

var x
var y

func _init():
	spell_name = "Flip"
	cost = 0
	unlocked_by_default = true
	variables = {"x" : "StackItem", "y" : "StackItem"}

func spell_effect():
	if x != null and y != null:
		returns.append(x)
		returns.append(y)
	return returns 
