class_name GustSelf

extends RuneSpell

var gust_power : float = 13.0

func _init():
	spell_name = "Vertical Gust"
	pattern = [AirRune.new().rune_name, AirRune.new().rune_name,  SelfRune.new().rune_name]

func spell_effect():
	caster.velocity.y = gust_power
