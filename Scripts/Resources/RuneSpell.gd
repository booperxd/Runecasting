class_name RuneSpell

extends Resource

var spell_name : String
var unlocked_by_default : bool = false
var cost : float = 2

var pattern : Array[Rune]

var caster : Being

func spell_effect():
	pass
	
