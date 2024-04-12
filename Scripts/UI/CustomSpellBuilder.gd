class_name CustomSpellBuilder

extends VBoxContainer

@onready var pattern_label : Label = $PatternContainer/Label
@onready var save_button : Button = $VBoxContainer/HBoxContainer/Save
@onready var spell_name_field : LineEdit = $NameContainer/SpellNameField

var current_config : Array[Array]

var learned_spells : LearnedSpells

func _ready():
	await(owner.ready)
	learned_spells = Global.player.player_spells
	process_mode = Node.PROCESS_MODE_ALWAYS
	Global.channel_finished.connect(update_spell_config)
	save_button.disabled = true
	
func update_spell_config(patterns):
	if patterns == null:
		current_config.clear()
		return
	for pattern in patterns:
		if pattern is Array:
			current_config.append(pattern)
			pattern_label.text = ""
			for s in current_config:
				pattern_label.text += str(s) + ", "
	if current_config.size() > 0:
		save_button.disabled = false


func _on_save_pressed():
	if !current_config.is_empty() and spell_name_field.text.length() > 1:
		var custom_spell = CustomSpell.new()
		custom_spell.spells = current_config.duplicate()
		custom_spell.spell_name = spell_name_field.text
		Global.custom_spell_added.emit(custom_spell)
		Global.open_toast.emit(custom_spell.spell_name + " has been saved!")
		spell_name_field.text = ""
		pattern_label.text = ""
		current_config.clear()
		save_button.disabled = true
