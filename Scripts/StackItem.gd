class_name StackItem

extends Node

var value

func _init(_value):
	value = _value

func stack_item_display() -> String:
	if value is int:
		return str(value)
	elif value is Entity:
		return value.p.name
	elif value is Vector3:
		return str(value)
	elif value is SpellStop and value.stopped:
		return "Focusing..."
	elif value is Array:
		return str(value)
	else:
		return ""
