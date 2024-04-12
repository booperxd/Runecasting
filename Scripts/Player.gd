class_name Player

extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 6.5
const FRICTION = 25
const HORIZONTAL_ACCELERATION = 30
const MAX_SPEED=5

const BOB_FREQ : float = 2.0
var t_bob :float = .8

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var player_spells = LearnedSpells.new()

var max_jumps : int = 1
var remaining_jumps : int

var player_settings : PlayerSettings

@onready var anim_player = $AnimationPlayer
@onready var raycast = $Head/Camera3D/RayCast3D
@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var rune_ui = $Head/Camera3D/CanvasLayer/RuneUI
@onready var stack_manager : StackManager = $StackManager

func _ready():
	Global.player = self
	Global.current_scene = get_tree().get_current_scene()
	Global.custom_spell_added.connect(on_custom_spell_added)
	player_settings = Global.player_settings
	Input.mouse_mode=Input.MOUSE_MODE_CAPTURED
	

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.mouse_mode==Input.MOUSE_MODE_CAPTURED:
		head.rotate_y(-event.relative.x * (player_settings.sens / 10))
		camera.rotate_x(-event.relative.y * (player_settings.sens / 10))
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
		#raycast.rotation = camera.rotation
		
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		remaining_jumps = max_jumps
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and Input.mouse_mode==Input.MOUSE_MODE_CAPTURED:
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_pressed("spell_1") and player_spells.custom_spell != null:
		stack_manager.stack.clear()
		for spell in player_spells.custom_spell.spells:
			stack_manager.process_custom_spell(spell)
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Vector3.ZERO
	var movetoward = Vector3.ZERO
	if rune_ui.visible == false:
		input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
		
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = lerp(velocity.x,direction.x * SPEED, delta * 8.0)
			velocity.z = lerp(velocity.z,direction.z * SPEED, delta * 8.0)
	else:
		velocity.x = lerp(velocity.x,direction.x * SPEED, delta * 3.0)
		velocity.z = lerp(velocity.z,direction.z * SPEED, delta * 3.0)
		
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = headbob()
	move_and_slide()
	#force_update_transform()

func headbob():
	var pos : Vector3 = Vector3.ZERO
	pos.y = sin(t_bob * BOB_FREQ) * player_settings.bob_amp
	pos.x = cos(t_bob * BOB_FREQ / 2) * player_settings.bob_amp
	return pos
	
func on_custom_spell_added(custom_spell):
	player_spells.add_custom_spell(custom_spell)
