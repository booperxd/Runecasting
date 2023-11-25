class_name Add

extends Spell

var x
var y

func _init():
	spell_name = "Addition"
	pattern = ["dru", "dru", "l", "dld", "dld"]
	cost = 0
	variables = {"x" : "int", "y" : "int"}

func spell_effect():
	if x != null and y != null:
		return x + y
	return null
