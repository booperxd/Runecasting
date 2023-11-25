class_name Subtract

extends Spell

var x
var y

func _init():
	spell_name = "Addition"
	pattern = ["dlu", "dlu", "r", "drd", "drd"]
	cost = 0
	variables = {"x" : "int", "y" : "int"}

func spell_effect():
	if x != null and y != null:
		return x - y
	return null
