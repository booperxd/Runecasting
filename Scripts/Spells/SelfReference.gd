class_name SelfReference

extends Spell

var entity

func _init():
	spell_name = "Self Reference"
	cost = 0
	unlocked_by_default = true

func spell_effect():
	returns.append(StackItem.new(entity))
	return returns
