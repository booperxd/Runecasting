class_name Spell


extends Resource

enum SpellCategory {
	Math,
	Scouting,
	Stack,
	Conjuration,
	Projectile,
	Effects,
	Elements
}

var spell_name : String
var unlocked_by_default : bool = false
var cost : float
var variables : Dictionary
var pattern : Array
var returns : Array 
var description : String
var category : SpellCategory

func spell_effect():
	pass

func handle_variables(passed_variables : Dictionary):
	for v in passed_variables:
		if variables[v] != null:
			set(v, passed_variables[v]) 
	
