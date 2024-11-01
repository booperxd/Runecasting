class_name SelfReference

extends Spell

var Being

func _init():
	spell_name = "Self Reference"
	cost = 0
	unlocked_by_default = true
	pattern = ["dur", "dul", "ddl", "ddr"]
	description = "Adds a reference to the player to the stack."
	category = SpellCategory.Scouting

func spell_effect():
	returns.append(StackItem.new(Being))
	return returns
