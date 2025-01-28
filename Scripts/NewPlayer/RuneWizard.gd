class_name RuneWizard

extends Being

@export var viewmodel : RuneWizardViewModel 

const LADDER_VELOCITY = 2.5


const BOB_FREQ : float = 2.0
var t_bob :float = .8

var input_dir : Vector2 = Vector2.ZERO


var player_spells : LearnedSpells

var was_on_floor : bool = false
var notebook_visible : bool = false
var max_jumps : int = 1
var remaining_jumps : int
var max_stamina : float = 100.0
var stamina : float = 100.0
var stamina_growth_rate : float = .1
var dash_cost : float = 33

var player_settings : PlayerSettings

@onready var state_machine : StateMachine = $StateMachine
@onready var raycast : RayCast3D = $Head/Camera3D/RayCast3D
@onready var camera : Camera3D = $Head/Camera3D
@onready var viewmodel_viewport :SubViewport = $Head/Camera3D/SubViewportContainer/SubViewport
@onready var viewmodel_scene : RuneWizardViewModel = $Head/Camera3D/SubViewportContainer/SubViewport/RuneWizardViewModel
@onready var pause_menu : Control = $Head/Camera3D/CanvasLayer/Menu/PauseMenu

var cur_interactable : Interactable

func _ready():
	super._ready()
	Global.player = self
	Global.current_scene = get_tree().get_current_scene()

	player_spells = LearnedSpells.load_or_create()
	for rune in player_spells.current_runes.keys():
		var page_num = int(rune[rune.length() - 1])
		Global.rune_changed.emit(player_spells.current_runes[rune], page_num)
	
	player_settings = Global.player_settings
	Input.mouse_mode=Input.MOUSE_MODE_CAPTURED
	stamina = max_stamina
	Global.set_player_stamina.emit(stamina)
	
	pause_menu.visible=false
	#viewmodel_viewport.size = DisplayServer.screen_get_size()
	#viewmodel_viewport.canvas_item_default_texture_filter = Viewport.DEFAULT_CANVAS_ITEM_TEXTURE_FILTER_NEAREST

#func _unhandled_input(event):
#	if event is InputEventMouseMotion and Input.mouse_mode==Input.MOUSE_MODE_CAPTURED:
#		head.rotate_y(-event.relative.x * (player_settings.sens / 10))
#		camera.rotate_x(-event.relative.y * (player_settings.sens / 10))
#		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
#		#raycast.rotation = camera.rotation
		
func _physics_process(delta):
	viewmodel.global_transform = camera.global_transform
	if stamina < max_stamina:
		stamina += stamina_growth_rate
		Global.set_player_stamina.emit(stamina)
	
	var movetoward = Vector3.ZERO
	if Input.is_action_just_pressed("pause"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		pause_menu.visible=true

	if Input.is_action_just_pressed("hide_notebook") and viewmodel is RuneWizardViewModel:
		if notebook_visible:
			notebook_visible = false
			viewmodel.left_arm_player.play("hide_book")
		else:
			notebook_visible = true
			viewmodel.left_arm_player.play("view book")
			
	if raycast.is_colliding():
		if raycast.get_collider() is Interactable and cur_interactable != raycast.get_collider():
			var interactable : Interactable = raycast.get_collider() as Interactable
			cur_interactable = interactable
			
			Global.interactable_near.emit(interactable)
			cur_interactable.on_interact_hit()
	elif cur_interactable != null:
		cur_interactable.on_interact_leave()
		cur_interactable = null
		Global.interactable_near.emit(cur_interactable)
	move_and_slide()


func headbob():
	var pos : Vector3 = Vector3.ZERO
	pos.y = sin(t_bob * BOB_FREQ) * player_settings.bob_amp
	pos.x = cos(t_bob * BOB_FREQ / 2) * player_settings.bob_amp
	return pos
	
func on_custom_spell_added(custom_spell, page):
	player_spells.add_custom_spell(custom_spell, page)
