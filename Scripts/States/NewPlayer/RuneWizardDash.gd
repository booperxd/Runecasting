class_name RuneWizardDash

extends RuneWizardState

@onready var dash_timer = $DashTimer

var starting_vel : Vector3

func enter():
	starting_vel = p.velocity
	starting_vel.y = 0
	Global.set_player_stamina.emit(p.stamina)
	p.input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (p.head.transform.basis * Vector3(p.input_dir.x, 0, p.input_dir.y)).normalized()	
	if direction == Vector3.ZERO:
		direction = p.get_direction()
		direction.y = 0
	p.velocity.y = 0
	p.velocity.x = p.HORIZONTAL_ACCELERATION * direction.x
	p.velocity.z = p.HORIZONTAL_ACCELERATION * direction.z
	
	dash_timer.start()

func update(delta):
	p.velocity.y = 0
	
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


func _on_dash_timer_timeout():
	p.velocity = starting_vel
	sm.transition("RuneWizardIdle")
