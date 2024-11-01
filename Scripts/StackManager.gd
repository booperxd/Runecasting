class_name StackManager

extends Node

var stack : Array
var learned_spells

var is_channelling : bool

func _ready():
	await(owner.ready)
	learned_spells = owner.player_spells
	Global.spell_finished.connect(process_spell)

func find_spell(pattern : Array):
	for spell in learned_spells.spells:
		if spell is Spell:
			if spell.pattern.size() == 0:
				continue
			if Global.check_if_all_dups(pattern) and pattern[0] == spell.pattern[0] and Global.check_if_all_dups(spell.pattern):
				if spell.variables.is_empty():
					if spell is Number:
						spell.number = pattern.size()
						return spell
			if pattern == spell.pattern:
				if spell.variables.is_empty():
					if spell is SelfReference:
						#this sucks, get rid of this
						spell.Being = Global.player.get_node("Being")
				elif not spell.variables.is_empty() and not is_channelling:
					var dict = {}
					for v in spell.variables:
						dict[v] = pop_stack()
					spell.handle_variables(dict)
				return spell
				#if Global.player_spells.check_if_player_knows_spell(spell):
				#	return spell
				#else:
				#	Global.open_toast.emit("The magic from your staff fizzles... that spell is unknown.")
		
	return null
	
func process_custom_spell(spell : Spell):
	var results_array = []
	if spell == null:
		pass
	if spell.variables.is_empty():
		if spell is SelfReference:
			#this sucks, get rid of this
			spell.Being = Global.player.get_node("Being")
	else:
		var dict = {}
		for v in spell.variables:
			dict[v] = pop_stack()
		spell.handle_variables(dict)
	results_array = await spell.spell_effect().duplicate()
	spell.returns.clear()
		
	for r in results_array:
		var s_i = r
		if s_i != null:
			push_stack(s_i)

func process_spell(pattern):
	var s = find_spell(pattern)
	if s == null:
		return null
	Global.open_toast.emit("Casted " + s.spell_name)
	var results_array = []
	if s is Channel:
		is_channelling = !is_channelling
		if !is_channelling:
			condense_patterns()
		Global.stack_changed.emit(stack)
	else:
		if is_channelling:
			push_stack(StackItem.new(s))
		else:
			results_array = await s.spell_effect().duplicate()
			if s is Spell:
				s.returns.clear()
			for r in results_array:
				var s_i = r
				if s_i != null and not is_channelling:	
					push_stack(s_i)

func condense_patterns():
	var spells : Array
	for stack_item in stack:
		if stack_item.value is Spell:
			spells.append(stack_item.value)
	for i in range(stack.size()-1, -1, -1):
		if stack[i].value is Spell:
			stack.remove_at(i)
	var pattern_sequence : StackItem = StackItem.new(spells)
	Global.channel_finished.emit(pattern_sequence.value)
	if spells.size() > 0:
		push_stack(pattern_sequence)

func push_stack(stack_item):
	stack.append(stack_item)
	Global.stack_changed.emit(stack)

func pop_stack():
	var temp = stack.pop_back()
	Global.stack_changed.emit(stack)
	return temp


