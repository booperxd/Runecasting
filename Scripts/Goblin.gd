extends CharacterBody3D

const SPEED = 2.0
const JUMP_VELOCITY = 4.5
const FRICTION = 25
const HORIZONTAL_ACCELERATION = 30
const MAX_SPEED=4

@export var sight_range : int = 50
@export var attack_range : int = 7
@export var damage : int = 3
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

var last_position_seen : Vector3

@onready var being : Being = $Being
@onready var agent : NavigationAgent3D = $NavigationAgent3D
@onready var sight_raycast : RayCast3D = $SightRaycast
@onready var attack_raycast : RayCast3D = $AttackRaycast
@onready var attack_timer : Timer = $AttackTimer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if last_position_seen != Vector3.ZERO and not sight_raycast.get_collider() is Player:
		agent.target_position = last_position_seen
	sight_raycast.target_position =  agent.target_position - self.global_position
	if attack_timer.is_stopped() and (sight_raycast.target_position.length() <= sight_range || last_position_seen != Vector3.ZERO):
		if sight_raycast.is_colliding() and sight_raycast.get_collider() is Player:
			last_position_seen = sight_raycast.get_collision_point()
		var next_location = agent.get_next_path_position()
		#velocity = velocity.move_toward((next_location - global_transform.origin) * SPEED, delta)
		velocity = (next_location - global_transform.origin).normalized() * SPEED
	else:
		velocity.x = 0
		velocity.z = 0
		
	velocity.y -= gravity * delta
	move_and_slide()

func update_target_location(pos):
	agent.target_position = pos
	attack_raycast.target_position = pos - self.global_position
	
func _on_navigation_agent_3d_target_reached():
	if agent.target_position == last_position_seen:
		last_position_seen = Vector3.ZERO
	elif attack_timer.is_stopped():
		attack_timer.start()
	velocity = Vector3.ZERO


func _on_attack_timer_timeout():
	#print(attack_raycast.target_position.length(), " | ", attack_raycast.get_collider())
	if attack_raycast.is_colliding() and attack_raycast.target_position.length() <= attack_range and attack_raycast.get_collider() is HitboxComponent:
		var hitbox : HitboxComponent = attack_raycast.get_collider() as HitboxComponent
		var attack : Attack = Attack.new(damage)
		hitbox.damage(attack)
		


func _on_health_component_on_goblin_hit():
	last_position_seen = Global.player.position
