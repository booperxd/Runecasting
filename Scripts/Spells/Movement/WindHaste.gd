class_name WindHaste

extends RuneSpell

func _init():
	spell_name = "Vertical Gust"
	pattern = [AirRune.new().rune_name,  SelfRune.new().rune_name]

func spell_effect():
	caster.add_effect(Haste.new())
