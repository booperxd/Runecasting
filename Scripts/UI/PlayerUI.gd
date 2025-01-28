extends Control

@onready var health_bar : TextureProgressBar = $HealthBar
@onready var rune_container : HBoxContainer = $BottomContainer
@onready var interaction_label : Label = $InteractionLabel
@onready var stamina_bar : TextureProgressBar = $StaminaBar
@onready var stack_container : HBoxContainer = $StackPanel/StackContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.set_player_health.connect(update_player_health)
	Global.rune_changed.connect(on_rune_changed)
	Global.interactable_near.connect(on_interaction_near)
	Global.set_player_stamina.connect(update_player_stamina)
	Global.stack_changed.connect(on_stack_changed)


func update_player_health(health : int, max_health):
	health_bar.max_value = max_health
	health_bar.value = health

func update_player_stamina(stamina : float):
	stamina_bar.value = stamina

func on_stack_changed(stack : Array[Rune]):
	for child in stack_container.get_children():
		stack_container.remove_child(child)
		child.queue_free()
		
	for rune in stack:
		var rune_text : TextureRect = TextureRect.new()
		rune_text.texture = rune.rune_icon
		stack_container.add_child(rune_text)
		
func on_rune_changed(rune : Rune, page : int):
	if rune == null or rune.rune_icon == null:
		return
	var page_text = rune_container.get_children()[page - 1]
	var rune_text = page_text.get_node("SpellIcon")
	rune_text.texture = rune.rune_icon

	var key = "rune_" + str(page)
	Global.player.player_spells.current_runes[key] = rune

func on_interaction_near(obj : Interactable):
	if obj == null:
		interaction_label.text = ""
	else:
		interaction_label.text = obj.interaction_description
