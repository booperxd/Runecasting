class_name PopStack 

extends Spell

var item

func _init():
	spell_name = "Pop Stack"
	cost = 0
	unlocked_by_default = true
	variables = {"item" : "StackItem"}

func spell_effect():
	return returns 
