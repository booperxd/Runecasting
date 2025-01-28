class_name RuneSelectionMenu

extends Control

@onready var select_runes : HBoxContainer = $SelectedRunes
@onready var rune_selectors : GridContainer = $RuneSelectors

var spell_data : LearnedSpells
var rune_icon_scene : PackedScene = load("res://Scenes/UI/rune_icon.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	await(owner.ready)
	spell_data = Global.player.player_spells
	for rune in spell_data.current_runes.keys():
		var rune_proper : Rune 
		if spell_data.current_runes[rune] != null:
			rune_proper = spell_data.current_runes[rune]
		else:
			rune_proper = Rune.new()
	for rune in spell_data.runes:
		var instance : RuneIcon = rune_icon_scene.instantiate() as RuneIcon
		instance.is_draggable = true
		rune_selectors.add_child(instance)
		instance.setup_icon(rune)
