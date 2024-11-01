class_name CustomSpellBuilder

extends VBoxContainer

@onready var pattern_label : Label = $PatternContainer/Label
@onready var save_button : Button = $VBoxContainer/HBoxContainer/Save
@onready var spell_name_field : LineEdit = $NameContainer/SpellNameField
@onready var page_list : ItemList = $VBoxContainer/CustomizerContainer/PageList
@onready var icon_list : ItemList = $VBoxContainer/CustomizerContainer/IconList

var current_config : Array[Spell]

var learned_spells : LearnedSpells

func _ready():
	await(owner.ready)
	learned_spells = Global.player.player_spells
	process_mode = Node.PROCESS_MODE_ALWAYS
	Global.channel_finished.connect(update_spell_config)
	save_button.disabled = true
	
func update_spell_config(patterns):
	current_config.clear()
	for pattern in patterns:
		if pattern is Spell:
			current_config.append(pattern)
			pattern_label.text = ""
			for s in current_config:
				pattern_label.text += str(s.spell_name) + ", "
	if current_config.size() > 0 and page_list.get_selected_items().size() == 1:
		save_button.disabled = false


func _on_save_pressed():
	if !current_config.is_empty() and spell_name_field.text.length() > 1:
		var custom_spell = CustomSpell.new()
		custom_spell.icon = icon_list.get_item_icon(icon_list.get_selected_items()[0])
		custom_spell.spells = current_config.duplicate()
		custom_spell.spell_name = spell_name_field.text
		Global.custom_spell_added.emit(custom_spell, page_list.get_selected_items()[0] + 1)
		Global.open_toast.emit(custom_spell.spell_name + " has been saved!")
		spell_name_field.text = ""
		pattern_label.text = ""
		page_list.deselect_all()
		icon_list.deselect_all()
		current_config.clear()
		save_button.disabled = true


func _on_page_list_item_selected(index):
	if current_config.size() > 0 and index != -1:
		save_button.disabled = false
