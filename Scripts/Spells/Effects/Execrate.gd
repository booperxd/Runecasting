extends Spell

var being : StackItem
var element : StackItem

func _init():
	spell_name = "Execrate"
	description = "Applies a negative effect to the entity, based on the element passed."
	pattern = ["ddr", "l", "ddl", "ddr", "r"]
	category = Spell.SpellCategory.Effects
	variables = {"being" : "Being", "element" : "Element"}
	
func spell_effect():
	if being != null and element != null and being.value is Being and element.value is Element:
		being.value.add_effect(element.value.effect)
	return returns
