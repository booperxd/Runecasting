extends Node3D

@export var rune_ui : Control
@export var notes_ui : Control
@export var pause_ui : Control
@export var spell_builder_ui : Control
@onready var toast_panel : Control = $"../Head/Camera3D/CanvasLayer/ToastPanel"

@onready var menus : Control = $"../Head/Camera3D/CanvasLayer/Menus"

var current_interaction : Global.Interactables

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	Global.interactable_near.connect(interact)

func _process(delta):
	if Input.is_action_just_pressed("toggle_notebook"):
		if !all_menus_closed(notes_ui):
			return
		notes_ui.visible = !notes_ui.visible
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if notes_ui.visible else Input.MOUSE_MODE_CAPTURED
		
	if Input.is_action_just_pressed("toggle_rune_ui"):
		if !all_menus_closed(rune_ui):
			return
		rune_ui.visible = !rune_ui.visible
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if rune_ui.visible else Input.MOUSE_MODE_CAPTURED
	if Input.is_action_just_pressed("interact") and current_interaction != null:
		if current_interaction == Global.Interactables.StudyTable:
			if !all_menus_closed(spell_builder_ui):
				return
			spell_builder_ui.visible = !spell_builder_ui.visible
			get_tree().paused = spell_builder_ui.visible
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if spell_builder_ui.visible else Input.MOUSE_MODE_CAPTURED
	if Input.is_action_just_pressed("pause"):
		if !all_menus_closed(pause_ui):
			return
		pause_ui.visible = !pause_ui.visible
		get_tree().paused = pause_ui.visible
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if pause_ui.visible else Input.MOUSE_MODE_CAPTURED
		
func interact(type : Global.Interactables):
	current_interaction = type

func all_menus_closed(ignore : Control) -> bool:
	for c in menus.get_children():
		if c.visible and c != ignore:
			return false
	return true
