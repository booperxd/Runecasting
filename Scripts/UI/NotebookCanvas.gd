class_name NotebookCanvas

extends Node3D

@onready var lines : Node2D = $Line

@onready var viewport : SubViewport = $".."

var _pressed_drawing : bool = false
var _pressed_erasing : bool = false
var _current_line : Line2D = null


func _ready():
	await(Global._ready)
	if Global.save_data != null and Global.save_data.player_notebook != null or !Global.save_data.player_notebook.is_empty():
		for line in Global.save_data.player_notebook:
			lines.add_child(line)

func _input(event):
	if !owner.visible:
		return
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			_pressed_drawing = event.pressed
			
			if _pressed_drawing:
				_current_line = Line2D.new()
				_current_line.default_color = Color.BLUE
				_current_line.width = 4
				lines.add_child(_current_line)
				_current_line.add_point(event.position)

	elif event is InputEventMouseMotion and _pressed_drawing:
		_current_line.add_point(event.position)
		
	if Input.is_action_just_pressed("notebook_delete") and lines.get_child_count() > 0:
		var removed_line = lines.get_children()[lines.get_child_count() - 1]
		removed_line.queue_free()

func get_lines() -> Array[Line2D]:
	var _lines : Array[Line2D]
	for line in lines.get_children():
		if line is Line2D:
			_lines.append(line)
	
	return _lines

