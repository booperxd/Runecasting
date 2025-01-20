class_name RuneWizardIdle

extends RuneWizardState


func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.mouse_mode==Input.MOUSE_MODE_CAPTURED:
		p.head.rotate_y(-event.relative.x * (p.player_settings.sens / 10))
		p.camera.rotate_x(-event.relative.y * (p.player_settings.sens / 10))
		p.camera.rotation.x = clamp(p.camera.rotation.x, -PI/2, PI/2)

func update(delta):
	p.input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	if not p.is_on_floor():
		p.velocity.y -= p.gravity * delta
	else:
		p.remaining_jumps = p.max_jumps
	

	if Input.is_action_just_pressed("toggle_rune_ui"):
		sm.transition("RuneWizardEditingRunes")
	
	if Input.is_action_just_pressed("toggle_notebook"):
		sm.transition("RuneWizardNotebookOpen")
	if Input.is_action_just_pressed("dash") and p.stamina >= p.dash_cost:
		p.stamina -= p.dash_cost
		sm.transition("RuneWizardDash")
	
	if Input.is_action_just_pressed("ui_accept") and p.is_on_floor() and Input.mouse_mode==Input.MOUSE_MODE_CAPTURED:
		sm.transition("RuneWizardJumping")
	
	if p.input_dir != Vector2.ZERO:
		sm.transition("RuneWizardMoving")
	
	if Input.is_action_just_pressed("rune_1") and p.player_spells.current_runes["rune_1"] != null:
		Global.rune_casted.emit(p.player_spells.current_runes["rune_1"])
	if Input.is_action_just_pressed("rune_2") and p.player_spells.current_runes["rune_2"] != null:
		Global.rune_casted.emit(p.player_spells.current_runes["rune_2"])
	if Input.is_action_just_pressed("rune_3") and p.player_spells.current_runes["rune_3"] != null:
		Global.rune_casted.emit(p.player_spells.current_runes["rune_3"])
	if Input.is_action_just_pressed("rune_4") and p.player_spells.current_runes["rune_4"] != null:
		Global.rune_casted.emit(p.player_spells.current_runes["rune_4"])
	if Input.is_action_just_pressed("rune_5") and p.player_spells.current_runes["rune_5"] != null:
		Global.rune_casted.emit(p.player_spells.current_runes["rune_5"])
	
	if Input.is_action_just_pressed("confirm_spell"):
		Global.spell_casted.emit()
	
	var direction = (p.head.transform.basis * Vector3(p.input_dir.x, 0, p.input_dir.y)).normalized()	
	
	if p.is_on_floor():
		if direction:
			p.velocity.x = direction.x * p.SPEED
			p.velocity.z = direction.z * p.SPEED
		else:
			p.velocity.x = lerp(p.velocity.x,direction.x * p.SPEED, delta * 8.0)
			p.velocity.z = lerp(p.velocity.z,direction.z * p.SPEED, delta * 8.0)
	else:
		p.velocity.x = lerp(p.velocity.x,direction.x * p.SPEED, delta * 3.0)
		p.velocity.z = lerp(p.velocity.z,direction.z * p.SPEED, delta * 3.0)
