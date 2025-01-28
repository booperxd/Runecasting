class_name RuneWizardNotebookOpen

extends RuneWizardState

@export var notebook_ui : DrawingNotebook

var notebook_image : ViewportTexture 

func _ready():
	super._ready()
	
	await RenderingServer.frame_post_draw
	
	notebook_image = notebook_ui.get_canvas_viewport()
	Global.notebook_saved.emit(notebook_image)
	notebook_ui.visible = false

func enter():
	notebook_ui.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func update(delta):
	if Input.is_action_just_pressed("toggle_notebook"):
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
	notebook_image = notebook_ui.get_canvas_viewport()
	Global.save_data.player_notebook = notebook_ui.canvas.get_lines()
	var image : Image = notebook_image.get_image()
	
	image.convert(Image.FORMAT_RGBA8)
	
	image.save_jpg("res://Material/test.jpg")
	
	Global.notebook_saved.emit(notebook_image)
	notebook_ui.visible = false
	
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED  


func _on_finale_spell_casted():
	sm.transition("RuneWizardIdle")
