class_name LearnedSpells

extends Resource

var spells : Array

func _init():
	spells = [Add.new(), EntityDirection.new(), EntityPosition.new(), Flip.new(), Multiply.new(), Number.new(), PopStack.new(), SelfReference.new(), Subtract.new() ]

func check_if_player_knows_spell(spell : Spell) -> bool:
	for s in spells:
		if s.spell_name == spell.spell_name:
			return true
	return false

func learn_spell(spell : Spell):
	if spells.has(spell):
		return
	spells.append(spell)
