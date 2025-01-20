extends Node

signal current_star(position)
signal player_learn_spell(spell)

signal rune_casted(rune : Rune)
signal stack_changed(stack)
signal spell_casted()
signal notebook_saved(bytes : ViewportTexture)

signal open_toast(text)
signal spell_finished(current_pattern)
signal interactable_near(type : Interactables)

signal finale_spell_casted()

signal set_player_health(new_health : int, max_health : int)
signal set_player_stamina(new_stamina : float)

signal custom_spell_added(custom_spell, page)
signal channel_finished(patterns)

signal rune_changed(rune, page)

signal enter_fight_room(room_name)
signal beat_fight_room(room_name)
signal enemy_beat_in_room()

var current_scene
var previous_scene : PackedScene
var player : RuneWizard
var player_settings : PlayerSettings
var save_data : SaveData

enum Interactables {
	None,
	StudyTable,
	Portal,
	Lever
}

func _ready():
	save_data = SaveData.load_or_create()
	player_settings = PlayerSettings.load_or_create()

func _process(delta):
	if player != null:
		get_tree().call_group("enemy", "update_target_location", player.global_transform.origin)

func check_if_all_dups(array : Array):
	var dict : Dictionary
	for i in range(0, array.size()):
		dict[array[i]] = null
	if dict.size() == 1:
		return true
	return false


