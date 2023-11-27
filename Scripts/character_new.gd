class_name Player

extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const FRICTION = 25
const HORIZONTAL_ACCELERATION = 30
const MAX_SPEED=5
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var sens = 0.001

var max_jumps : int = 1
var remaining_jumps : int

@onready var anim_player = $AnimationPlayer
@onready var camera = $Camera3D
@onready var rune_ui = $Camera3D/CanvasLayer/RuneUI


func _ready():
	Global.current_scene = get_tree()
	Input.mouse_mode=Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event):
	if Input.is_action_just_pressed("toggle_rune_ui"):
		if Input.mouse_mode==Input.MOUSE_MODE_CAPTURED: 
			Input.mouse_mode=Input.MOUSE_MODE_VISIBLE
			rune_ui.visible = true
		else:
			Input.mouse_mode=Input.MOUSE_MODE_CAPTURED
			rune_ui.visible = false
	elif event is InputEventMouseMotion and Input.mouse_mode==Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * sens)
		camera.rotate_x(-event.relative.y * sens)
		camera.rotation.x = clamp(camera.rotation.x, -PI/2, PI/2)
		
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	else:
		remaining_jumps = max_jumps
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and remaining_jumps > 0 and Input.mouse_mode==Input.MOUSE_MODE_CAPTURED:
		if not is_on_floor():
			remaining_jumps-=1
		velocity.y = JUMP_VELOCITY
		
		
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Vector3.ZERO
	var movetoward = Vector3.ZERO
	if rune_ui.visible == false:
		input_dir.x = Input.get_vector("move_left", "move_right", "move_forward", "move_backward").x
		input_dir.y = Input.get_vector("move_left", "move_right", "move_forward", "move_backward").y
		input_dir=input_dir.normalized()
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	direction *= SPEED
	velocity.x = move_toward(velocity.x,direction.x, HORIZONTAL_ACCELERATION * delta)
	velocity.z = move_toward(velocity.z,direction.z, HORIZONTAL_ACCELERATION * delta)

	var angle=5
	#rotation_degrees=Vector3(input_dir.normalized().y*angle,rotation_degrees.y,-input_dir.normalized().x*angle)
	var t = delta * 6
	#if Input.mouse_mode==Input.MOUSE_MODE_CAPTURED: 
	#	rotation_degrees=rotation_degrees.lerp(Vector3(input_dir.normalized().y*angle,rotation_degrees.y,-input_dir.normalized().x*angle),t)
	
	move_and_slide()
	force_update_transform()
