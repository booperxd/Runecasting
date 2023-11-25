class_name Spell

extends Node

var spell_name : String
var pattern : Array
var cost : float
var variables : Dictionary

func spell_effect():
	pass

func handle_variables(passed_variables : Dictionary):
	for v in passed_variables:
		if variables[v] != null:
			set(v, passed_variables[v]) 
