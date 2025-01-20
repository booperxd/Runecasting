class_name FireSpell

extends Spell

func _init():
	spell_name = "Conjure Element : Fire"
	cost = 0
	unlocked_by_default = true
	pattern = ["d", "r", "ddl"]
	description = "Conjure the element of fire!"
	category = SpellCategory.Elements

func spell_effect():
	returns.append(StackItem.new(FireElement.new()))
	return returns
