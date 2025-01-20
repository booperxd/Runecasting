class_name PlayerMoving

extends PlayerState


func update(delta):
	p.input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	if not p.is_on_floor():
		p.velocity.y -= p.gravity * delta
	else:
		p.remaining_jumps = p.max_jumps
	
	if Input.is_action_just_pressed("toggle_rune_ui"):
		sm.transition("PlayerCasting")
	
	if Input.is_action_just_pressed("toggle_notebook"):
		sm.transition("PlayerNotebookOpen")
	
	if Input.is_action_just_pressed("dash") and p.stamina >= p.dash_cost:
		p.stamina -= p.dash_cost
		sm.transition("PlayerDash")
	
	if Input.is_action_just_pressed("ui_accept") and p.is_on_floor() and Input.mouse_mode==Input.MOUSE_MODE_CAPTURED:
		sm.transition("PlayerJumping")
	
	if p.input_dir == Vector2.ZERO:
		sm.transition("PlayerIdle")
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
