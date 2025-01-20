class_name Being

extends CharacterBody3D

var head : Node3D

var START_GRAVITY = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var S_SPEED = 4.0
@export var S_JUMP_VELOCITY = 4.5
@export var S_FRICTION = 25
@export var S_HORIZONTAL_ACCELERATION = 30
@export var S_MAX_SPEED=4

var SPEED
var JUMP_VELOCITY
var FRICTION
var HORIZONTAL_ACCELERATION 
var MAX_SPEED
var gravity

@export var health_component : HealthComponent
@export var hitbox_component : HitboxComponent

var effects : Array

func _ready():
	SPEED = S_SPEED
	JUMP_VELOCITY = S_JUMP_VELOCITY
	FRICTION = S_FRICTION
	HORIZONTAL_ACCELERATION = S_HORIZONTAL_ACCELERATION
	MAX_SPEED=S_MAX_SPEED
	gravity = START_GRAVITY
	head = get_node("Head")
	if get_node("HealthComponent") != null:
		health_component = get_node("HealthComponent") as HealthComponent
	if get_node("HitboxComponent") != null:
		hitbox_component = get_node("HitboxComponent") as HitboxComponent
		
func get_direction() -> Vector3:
	if head.get_node("Camera3D") != null:
		var camera : Camera3D = head.get_node("Camera3D") as Camera3D
		return camera.get_global_transform().basis.z * -1
	return Vector3.ZERO

func add_effect(effect):
	effects.append(effect)
	effect.being = self as Being
	add_child(effect)
