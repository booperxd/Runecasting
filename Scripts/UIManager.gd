extends Node3D

@export var rune_ui : Control
@export var notes_ui : Control

var drawing_visible : bool
var notes_visible : bool


func _process(delta):
	if Input.is_action_just_pressed("toggle_notebook") and not drawing_visible:
		notes_visible = !notes_visible
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if notes_visible else Input.MOUSE_MODE_CAPTURED
		notes_ui.visible = notes_visible
		
	if Input.is_action_just_pressed("toggle_rune_ui")  and not notes_visible:
		drawing_visible = !drawing_visible
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if drawing_visible else Input.MOUSE_MODE_CAPTURED
		rune_ui.visible = drawing_visible
