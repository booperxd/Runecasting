class_name MeteorObject

extends RigidBody3D

@onready var self_destruct_timer : Timer = $SelfDestructTimer

@export var rolling_speed : float = 1.5 
@export var damage : float = 15.0

var direction : Vector3

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	constant_force = (direction.normalized() * rolling_speed)


func _on_collision_hitbox_area_entered(area):
	if area is HitboxComponent:	
		var hitbox : HitboxComponent = area
		var attack : Attack = Attack.new(damage)
		hitbox.damage(attack)


func _on_self_destruct_timer_timeout():
	queue_free()
