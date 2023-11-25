class_name StackManager

extends Node

const SPELL_PATH = "res://Scripts/Spells/"
var stack : Array
var spell_data : Dictionary

func _ready():
	var f = FileAccess.open("res://Scripts/Spells/spells.json", FileAccess.READ)
	var content = f.get_as_text()
	var json = JSON.new()
	spell_data = json.parse_string(content)

func find_spell(pattern : Array):
	var spell = null
	for p in spell_data:
		if pattern == spell_data[p]:
			spell = load(SPELL_PATH + p + ".gd").new()
			if not spell.variables.is_empty():
				var dict = {}
				for v in spell.variables:
					dict[v] = pop_stack().value
				spell.handle_variables(dict)
			return spell
			
		elif Global.check_if_all_dups(pattern) and pattern[0] == spell_data[p][0]:
			spell = load(SPELL_PATH + p + ".gd").new()
			if not spell.variables.is_empty():
				var dict = {}
				for v in spell.variables:
					dict[v] = pattern.size()
				spell.handle_variables(dict)
			return spell
	
	return null

func process_spell(pattern : Array):
	var s = find_spell(pattern)
	if s == null:
		return null
	var s_i = StackItem.new()
	s_i.value = s.spell_effect()
	if s_i != null:
		push_stack(s_i)

func push_stack(stack_item):
	stack.append(stack_item)
	Global.stack_changed.emit(stack)

func pop_stack():
	return stack.pop_back()
	Global.stack_changed.emit(stack)

func get_pattern_direction(o : Vector2, d : Vector2):
	if o.y == d.y:
		if d.x > o.x:
			return "r"
		else:
			return "l"
	#diag up
	elif d.y < o.y:
		if d.x > o.x:
			return "dur"
		else:
			return "dul"
	elif d.y > o.y:
		if d.x > o.x:
			return "ddr"
		else:
			return "ddl"
	else:
		return "?"
