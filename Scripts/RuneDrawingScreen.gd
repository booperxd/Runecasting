extends VBoxContainer

var hovering_star : Vector2
var next_star : Vector2
var next_star_used : bool
var is_drawing : bool
var current_pattern : Array

var line = Line2D
var line_inst

@onready var stack_manager : StackManager = $StackManager
@onready var stack_display = $HBoxContainer/StackDisplay/StackContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.current_star.connect(at_star)
	Global.stack_changed.connect(update_stack_display)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if is_drawing:
		line_inst.points[line_inst.points.size() - 1] = get_global_mouse_position()
	if hovering_star != Vector2.ZERO:
		if Input.is_action_pressed("select_star"):
			if not is_drawing:
				is_drawing = true
				line_inst = line.new()
				line_inst.add_point(hovering_star)
				line_inst.add_point(hovering_star)
				add_child(line_inst)
			elif next_star != Vector2.ZERO and not next_star_used:
				line_inst.points[line_inst.points.size() - 1] = next_star
				line_inst.add_point(next_star)
				current_pattern.append(stack_manager.get_pattern_direction(line_inst.points[line_inst.points.size() - 3], line_inst.points[line_inst.points.size() - 2]))
				next_star = Vector2.ZERO
				next_star_used = true
			#print(line_inst.points.size())
		else:
			is_drawing = false
			next_star = Vector2.ZERO
			if (line_inst != null):
				line_inst.queue_free()
		if Input.is_action_just_released("select_star"):
			hovering_star = Vector2.ZERO
			stack_manager.process_spell(current_pattern)
			current_pattern.clear()

func at_star(star_pos):
	if not is_drawing:
		hovering_star = star_pos
	else:
		next_star = star_pos
		next_star_used = false

func update_stack_display(stack):
	for c in stack_display.get_children():
		c.queue_free()
	for s_i in stack:
		var label = Label.new()
		label.text = str(s_i.value)
		stack_display.add_child(label)
