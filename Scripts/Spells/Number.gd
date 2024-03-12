class_name Number

extends Spell

var number

func _init():
	spell_name = "Number"
	cost = 0
	unlocked_by_default = true

func spell_effect():
	returns.append(StackItem.new(number))
	return returns

