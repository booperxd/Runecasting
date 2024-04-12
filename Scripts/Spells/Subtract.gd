class_name Subtract

extends Spell

var x
var y

func _init():
	spell_name = "Subtract"
	cost = 0
	variables = {"x" : "int", "y" : "int"}
	unlocked_by_default = true
	pattern = ["r", "dul", "ddl"]
	description = "Removes two elements from the stack and adds the difference to the queue."
	category = SpellCategory.Math

func spell_effect():
	if x != null and y != null:
		returns.append(StackItem.new(x.value - y.value))
	return returns
