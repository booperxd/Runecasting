class_name StackItem

extends Resource

var value

func _init(_value):
	value = _value

func stack_item_display() -> String:
	if value is int:
		return str(value)
	elif value is Being:
		return value.p.name
	elif value is Vector3:
		return str(value)
	elif value is SpellStop and value.stopped:
		return "Focusing..."
	elif value is Element:
		return value.element_name
	elif value is Array:
		if value.size() <= 0:
			return str(value)
		if value[0] is Spell:
			var output : String = ""
			for spell in value:
				output += spell.spell_name + ", "
			return output
		return str(value)
	elif value is Spell:
		return str(value.spell_name)
	else:
		return ""
