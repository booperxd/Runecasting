class_name Number

extends Spell

var number

func _init():
	spell_name = "Number"
	pattern = ["r"]
	cost = 0
	variables = {"number" : "int"}

func spell_effect():
	returns.append(StackItem.new(number))
	return returns

