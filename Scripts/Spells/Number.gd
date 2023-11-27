class_name Number

extends Spell

var number

func _init():
	spell_name = "Number"
	cost = 0

func spell_effect():
	returns.append(StackItem.new(number))
	return returns

