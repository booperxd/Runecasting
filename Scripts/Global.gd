extends Node

signal current_star(position)
signal player_learn_spell(spell)
signal stack_changed(stack)
signal open_toast(text)

var current_scene

var player_spells := LearnedSpells.new()

func check_if_all_dups(array : Array):
	var dict : Dictionary
	for i in range(0, array.size()):
		dict[array[i]] = null
	if dict.size() == 1:
		return true
	return false
