class_name WrittenSpells

extends Resource

var max_size = 9

var custom_spells : Array[CustomSpell]

func add_custom_spell(pos : int, new_spell : CustomSpell) -> bool:
	if pos < 0 or pos >= max_size:
		return false
	custom_spells[pos] = new_spell
	return true
