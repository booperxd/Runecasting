class_name Number

extends Spell

var number

func _init():
	spell_name = "Number"
	pattern = ["r"]
	cost = 0
	unlocked_by_default = true
	description="Adds a number to the stack
			\nEach line is equal to one number.
			\nEx: --- is equal to 3, ----- is equal to 5"
	category = SpellCategory.Math

func spell_effect():
	returns.append(StackItem.new(number))
	return returns

