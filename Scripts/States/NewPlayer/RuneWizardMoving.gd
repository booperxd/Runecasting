class_name RuneWizardMoving

extends RuneWizardState


func update(delta):
	p.input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	if not p.is_on_floor():
		p.velocity.y -= p.gravity * delta
	else:
		p.remaining_jumps = p.max_jumps
	
	if Input.is_action_just_pressed("toggle_notebook"):
		sm.transition("RuneWizardNotebookOpen")
	
	if Input.is_action_just_pressed("toggle_rune_ui"):
		sm.transition("RuneWizardEditingRunes")
	
	if Input.is_action_just_pressed("dash") and p.stamina >= p.dash_cost:
		p.stamina -= p.dash_cost
		sm.transition("RuneWizardDash")
	
	if Input.is_action_just_pressed("ui_accept") and p.is_on_floor() and Input.mouse_mode==Input.MOUSE_MODE_CAPTURED:
		sm.transition("RuneWizardJumping")
	
	if Input.is_action_just_pressed("confirm_spell"):
		Global.spell_casted.emit()
	
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
	
	if p.input_dir == Vector2.ZERO:
		sm.transition("RuneWizardIdle")
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
	p.t_bob += delta * p.velocity.length() * float(p.is_on_floor())
	p.camera.transform.origin = p.headbob()
	
