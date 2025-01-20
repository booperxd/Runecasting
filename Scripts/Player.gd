class_name Player

extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 3.5
const LADDER_VELOCITY = 2.5
const FRICTION = 25
const HORIZONTAL_ACCELERATION = 15
const MAX_SPEED=5

const BOB_FREQ : float = 2.0
var t_bob :float = .8

var input_dir : Vector2 = Vector2.ZERO
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var player_spells : LearnedSpells

var was_on_floor : bool = false
var max_jumps : int = 1
var remaining_jumps : int
var max_stamina : float = 100.0
var stamina : float = 100.0
var stamina_growth_rate : float = .1
var dash_cost : float = 33

var player_settings : PlayerSettings

@onready var anim_player = $AnimationPlayer
@onready var raycast = $Head/Camera3D/RayCast3D
@onready var head = $Head
@onready var camera = $Head/Camera3D
@onready var rune_ui = $Head/Camera3D/CanvasLayer/Menus/RuneUI
@onready var stack_manager : StackManager = $StackManager


func _ready():
	Global.current_scene = get_tree().get_current_scene()
	Global.custom_spell_added.connect(on_custom_spell_added)
	player_spells = LearnedSpells.load_or_create()
	for custom_spell in player_spells.custom_spells:
		Global.custom_spell_added.emit(player_spells.custom_spells[custom_spell], custom_spell)
	player_settings = Global.player_settings
	Input.mouse_mode=Input.MOUSE_MODE_CAPTURED
	stamina = max_stamina
	Global.set_player_stamina.emit(stamina)
	

#func _unhandled_input(event):
#	if event is InputEventMouseMotion and Input.mouse_mode==Input.MOUSE_MODE_CAPTURED:
#		head.rotate_y(-event.relative.x * (player_settings.sens / 10))
#		camera.rotate_x(-event.relative.y * (player_settings.sens / 10))
#		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
#		#raycast.rotation = camera.rotation
		
func _physics_process(delta):
	# Add the gravity.
	
	
	# Handle Jump.
	
	if stamina < max_stamina:
		stamina += stamina_growth_rate
		Global.set_player_stamina.emit(stamina)
	
#	if Input.is_action_pressed("ui_accept") and on_ladder:
#		velocity.y = LADDER_VELOCITY
	
	if Input.is_action_just_pressed("spell_1") and player_spells.custom_spells.has(1):
		stack_manager.stack.clear()
		Global.open_toast.emit("Casted " + player_spells.custom_spells.get(1).spell_name)
		for spell in player_spells.custom_spells.get(1).spells:
			stack_manager.process_custom_spell(spell)
	if Input.is_action_just_pressed("spell_2") and player_spells.custom_spells.has(2):
		stack_manager.stack.clear()
		Global.open_toast.emit("Casted " + player_spells.custom_spells.get(2).spell_name)
		for spell in player_spells.custom_spells.get(2).spells:
			stack_manager.process_custom_spell(spell)
	if Input.is_action_just_pressed("spell_3") and player_spells.custom_spells.has(3):
		stack_manager.stack.clear()
		Global.open_toast.emit("Casted " + player_spells.custom_spells.get(3).spell_name)
		for spell in player_spells.custom_spells.get(3).spells:
			stack_manager.process_custom_spell(spell)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	
	var movetoward = Vector3.ZERO
#	if rune_ui.visible == false:
#		input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
		
	#var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
#	if is_on_floor():
#		if direction:
#			velocity.x = direction.x * SPEED
#			velocity.z = direction.z * SPEED
#		else:
#			velocity.x = lerp(velocity.x,direction.x * SPEED, delta * 8.0)
#			velocity.z = lerp(velocity.z,direction.z * SPEED, delta * 8.0)
#	else:
#		velocity.x = lerp(velocity.x,direction.x * SPEED, delta * 3.0)
#		velocity.z = lerp(velocity.z,direction.z * SPEED, delta * 3.0)
		
#	t_bob += delta * velocity.length() * float(is_on_floor())
#	camera.transform.origin = headbob()
	move_and_slide()
	#snap_to_stairs()
	#force_update_transform()


#func snap_to_stairs():
#	if not is_on_floor() and velocity.y <= 0 and was_on_floor:
#		var body_test = PhysicsTestMotionResult3D.new()
#		var params = PhysicsTestMotionParameters3D.new()
#		var max_step_down = -1.2
#		params.from = self.global_transform
#		params.motion = Vector3(0, max_step_down, 0)
#		if (PhysicsServer3D.body_test_motion(self.get_rid(), params, body_test)):
#			var translate = body_test.get_travel().y
#			position.y += translate
#			apply_floor_snap()
#	was_on_floor = is_on_floor()

func headbob():
	var pos : Vector3 = Vector3.ZERO
	pos.y = sin(t_bob * BOB_FREQ) * player_settings.bob_amp
	pos.x = cos(t_bob * BOB_FREQ / 2) * player_settings.bob_amp
	return pos
	
func on_custom_spell_added(custom_spell, page):
	player_spells.add_custom_spell(custom_spell, page)
