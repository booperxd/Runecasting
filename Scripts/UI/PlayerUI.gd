extends Control

@onready var health_bar : TextureProgressBar = $BottomContainer/HealthBar
@onready var spell_container : HBoxContainer = $BottomContainer/SpellContainer
@onready var interaction_label : Label = $InteractionLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.set_player_health.connect(update_player_health)
	Global.custom_spell_added.connect(on_custom_spell_added)
	Global.interactable_near.connect(on_interaction_near)


func update_player_health(health : int, max_health):
	health_bar.max_value = max_health
	health_bar.value = health

func on_custom_spell_added(spell : CustomSpell, page : int):
	if spell.icon == null:
		pass
	var page_text = spell_container.get_children()[page - 1]
	var spell_text = page_text.get_node("SpellIcon")
	spell_text.texture = spell.icon

func on_interaction_near(type : Global.Interactables):
	if type == Global.Interactables.StudyTable:
		interaction_label.text = "E to open study table"
	elif type == Global.Interactables.Portal:
		interaction_label.text = "E to go through portal"
	elif type == Global.Interactables.Lever:
		interaction_label.text = "E to flip lever"
	else:
		interaction_label.text=""
