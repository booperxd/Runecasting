class_name NotebookCanvas

extends Node3D

@onready var lines : Node2D = $Line

@onready var viewport : SubViewport = $".."

var _pressed_drawing : bool = false
var _pressed_erasing : bool = false
var _current_line : Line2D = null


func _ready():
	await(Global._ready)
	
	if Global.save_data != null and Global.save_data.packed_notebook != null:
		var saved_lines : Line2D = Global.save_data.unpack_notebook() 
		if saved_lines == null:
			return
		for line in saved_lines.get_children():
			saved_lines.remove_child(line)
			line.set_owner(lines)
			
			lines.add_child(line)
			Global.save_data.player_notebook = lines

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
				_current_line.owner = lines
				lines.add_child(_current_line)
				_current_line.add_point(event.position)

	elif event is InputEventMouseMotion and _pressed_drawing:
		_current_line.add_point(event.position)
		
	if Input.is_action_just_pressed("notebook_delete") and lines.get_child_count() > 0:
		var removed_line = lines.get_children()[lines.get_child_count() - 1]
		removed_line.queue_free()

func get_lines() -> Line2D:
	return lines

