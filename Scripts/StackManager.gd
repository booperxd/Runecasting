class_name StackManager

extends Node

const SPELL_PATH = "res://Scripts/Spells/"
var stack : Array
var spell_data : Dictionary

func _ready():
	var f = FileAccess.open("res://Scripts/Spells/spell_info.json", FileAccess.READ)
	var content = f.get_as_text()
	var json = JSON.new()
	spell_data = json.parse_string(content)

func find_spell(pattern : Array):
	var spell = null
	for category in spell_data:
		for s in spell_data[category]:
			var s_pattern = spell_data[category][s]["pattern"]
			var s_name = spell_data[category][s]["script_name"]
			if Global.check_if_all_dups(pattern) and pattern[0] == s_pattern[0] and Global.check_if_all_dups(s_pattern):
				spell = load(SPELL_PATH + s_name + ".gd").new()
				if spell.variables.is_empty():
					if spell is Number:
						spell.number = pattern.size()
				if Global.player_spells.check_if_player_knows_spell(spell):
					return spell
				else:
					print('player does not know spell!!')
			if pattern == s_pattern:
				spell = load(SPELL_PATH + s_name + ".gd").new()
				if spell.variables.is_empty():
					if spell is SelfReference:
						#this sucks, get rid of this
						spell.entity = owner.owner.get_node("Entity")
				elif not spell.variables.is_empty():
					var dict = {}
					for v in spell.variables:
						dict[v] = pop_stack()
					spell.handle_variables(dict)
				if Global.player_spells.check_if_player_knows_spell(spell):
					return spell
				else:
					Global.open_toast.emit("The magic from your staff fizzles... that spell is unknown.")
		
	return null

func process_spell(pattern : Array):
	var s = find_spell(pattern)
	if s == null:
		return null
	var results_array = []
	results_array = await s.spell_effect()
	for r in results_array:
		var s_i = r
		if s_i != null:
			push_stack(s_i)

func push_stack(stack_item):
	stack.append(stack_item)
	Global.stack_changed.emit(stack)

func pop_stack():
	var temp = stack.pop_back()
	Global.stack_changed.emit(stack)
	return temp

func get_pattern_direction(o : Vector2, d : Vector2):
	if o.x == d.x:
		if d.y < o.y:
			return "u"
		else:
			return "d"
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
