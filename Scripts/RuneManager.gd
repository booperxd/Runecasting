class_name RuneManager

extends Node

var stack : Array[Rune]
var learned_spells : Array[RuneSpell]

func _ready():
	await(owner.ready)
	Global.rune_casted.connect(push_stack)
	Global.spell_casted.connect(on_spell_casted)
	learned_spells = owner.player_spells.spells

func on_spell_casted():
	if stack.is_empty():
		return
		
	var stack_rune_pattern : Array[String]
	while !stack.is_empty():
		stack_rune_pattern.append(pop_stack().rune_name)
		
	for spell in learned_spells:
		var spell_rune_pattern : Array[String]
		for rune in spell.pattern:
			spell_rune_pattern.append(rune.rune_name)
		if spell_rune_pattern == stack_rune_pattern:
			spell.caster = owner as Being
			spell.spell_effect()
			Global.open_toast.emit(str("Cast ", spell.spell_name))
			return
		

func push_stack(_rune : Rune):
	stack.append(_rune)
	Global.stack_changed.emit(stack)
	
func pop_stack() -> Rune:
	if stack.is_empty():
		return
	var popped_rune = stack.pop_at(0)
	Global.stack_changed.emit(stack)
	return popped_rune
