class_name LearnedSpells

extends Resource

var spell_data : SpellData = ResourceLoader.load("res://Scripts/Resources/SpellData.gd").new()

var custom_spells : Array
var custom_spell : CustomSpell

var spells : Array

func _init():
	for s in spell_data.spells:
		#if s is Spell and s.unlocked_by_default:
		spells.append(s)
		

func check_if_player_knows_spell(spell) -> bool:
	if spell is Spell:
		for s in spells:
			if s.spell_name == spell.spell_name:
				return true
	if spell is String:
		for s in spells:
			if s.spell_name == spell:
				return true
	return false

func learn_spell(spell : Spell):
	if spells.has(spell):
		return
	spells.append(spell)

func add_custom_spell(new_spell : CustomSpell):
	custom_spell = new_spell
