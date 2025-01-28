class_name WindHaste

extends RuneSpell

func _init():
	spell_name = "Vertical Gust"
	pattern = [AirRune.new(),  SelfRune.new()]

func spell_effect():
	caster.add_effect(Haste.new())
