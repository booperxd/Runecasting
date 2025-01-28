extends Panel

var first_level : PackedScene = load("res://Scenes/Levels/pocket_dimension.tscn")

func _on_pyromancer_button_button_down():
	clear_data();
	var spells : LearnedSpells = LearnedSpells.load_or_create()
	spells.runes.append(FireRune.new())
	spells.save()
	
	get_tree().change_scene_to_packed(first_level)

func clear_data():
	LearnedSpells.delete()
	SaveData.delete()


func _on_debug_button_button_down():
	clear_data();
	var spells : LearnedSpells = LearnedSpells.load_or_create()
	spells.runes.clear()
	for rune in spells.spell_data.runes:
		spells.runes.append(rune)
	spells.save()
	
	get_tree().change_scene_to_packed(first_level)
