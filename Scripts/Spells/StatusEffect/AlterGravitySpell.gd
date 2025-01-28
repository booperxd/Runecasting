class_name AlterGravitySpell

extends RuneSpell

func _init():
	spell_name = "Alter Gravity"
	pattern = [GravityRune.new(), SelfRune.new()]

func spell_effect():
	caster.add_effect(LowGravity.new())
