class_name AlterGravitySpell

extends RuneSpell

func _init():
	spell_name = "Alter Gravity"
	pattern = [GravityRune.new().rune_name, SelfRune.new().rune_name]

func spell_effect():
	caster.add_effect(LowGravity.new())
