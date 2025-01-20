class_name HeavySpell

extends Spell

func _init():
	spell_name = "Heavy"
	cost = 0
	unlocked_by_default = true
	pattern = ["d", "dur", "u"]
	description = "Heavy spells are usually slower, do more damage, and last longer. Spell cost will be increased."
	category = SpellCategory.Modifiers

func spell_effect():
	returns.append(StackItem.new(HeavyModifier.new()))
	return returns
