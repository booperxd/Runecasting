class_name PlayerCasting

extends PlayerState

@export var rune_ui : BoxContainer

func enter():
	Global.finale_spell_casted.connect(_on_finale_spell_casted)
	rune_ui.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func update(delta):
	if Input.is_action_just_pressed("toggle_rune_ui"):
		sm.transition("PlayerIdle")
	
	#p.input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	#var direction = (p.head.transform.basis * Vector3(p.input_dir.x, 0, p.input_dir.y)).normalized()	
	if p.is_on_floor():
		p.velocity.x = lerp(p.velocity.x,0.0, delta * 8.0)
		p.velocity.z = lerp(p.velocity.z,0.0, delta * 8.0)
	else:
		p.velocity.x = lerp(p.velocity.x,0.0, delta * 3.0)
		p.velocity.z = lerp(p.velocity.z,0.0, delta * 3.0)

func exit():
	rune_ui.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED  
	Global.finale_spell_casted.disconnect(_on_finale_spell_casted)

func _on_finale_spell_casted():
	sm.transition("PlayerIdle")
