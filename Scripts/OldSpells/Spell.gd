class_name Spell


extends Resource

enum SpellCategory {
	Math,
	Scouting,
	Stack,
	Conjuration,
	Projectile,
	Effects,
	Elements,
	Modifiers
}

var spell_name : String
var unlocked_by_default : bool = false
var cost : float

var variables : Dictionary
var modifiers : Array[Modifier]

var pattern : Array
var returns : Array 
var description : String
var category : SpellCategory

var caster : Being

func spell_effect():
	pass

func handle_variables(passed_variables : Dictionary, new_modifiers : Array[Modifier]):
	modifiers = new_modifiers
	for v in passed_variables:
		if variables[v] != null and passed_variables[v] is StackItem:
			set(v, passed_variables[v].value) 
	
