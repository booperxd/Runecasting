class_name RuneWizardEditingRunes

extends RuneWizardState

@export var rune_edit_ui : Control

func enter():
	rune_edit_ui.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func update(delta):
	if Input.is_action_just_pressed("toggle_rune_ui"):
		sm.transition("RuneWizardIdle")
	
	if not p.is_on_floor():
		p.velocity.y -= p.gravity * delta
	else:
		p.remaining_jumps = p.max_jumps
	#p.input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	#var direction = (p.head.transform.basis * Vector3(p.input_dir.x, 0, p.input_dir.y)).normalized()	
	if p.is_on_floor():
		p.velocity.x = lerp(p.velocity.x,0.0, delta * 8.0)
		p.velocity.z = lerp(p.velocity.z,0.0, delta * 8.0)
	else:
		p.velocity.x = lerp(p.velocity.x,0.0, delta * 3.0)
		p.velocity.z = lerp(p.velocity.z,0.0, delta * 3.0)

func exit():
	rune_edit_ui.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED  

