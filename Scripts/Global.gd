extends Node

signal current_star(position)
signal player_learn_spell(spell)
signal stack_changed(stack)
signal open_toast(text)
signal spell_finished(current_pattern)
signal interactable_near(type : Interactables)

signal custom_spell_added(custom_spell)
signal channel_finished(patterns)

var current_scene
var player : Player
var player_settings : PlayerSettings

enum Interactables {
	None,
	StudyTable
}

func _ready():
	player_settings = PlayerSettings.load_or_create()

func check_if_all_dups(array : Array):
	var dict : Dictionary
	for i in range(0, array.size()):
		dict[array[i]] = null
	if dict.size() == 1:
		return true
	return false


