class_name Projectile

extends CharacterBody3D

@export var area_collision : Area3D
@export var particles : GPUParticles3D
@export var collision : CollisionShape3D
@export var particle_timer : Timer 
@export var selfdestruct_timer : Timer

@export var speed : float = 20
@export var damage : float = 3.0

var cur_speed : float = 20
var cur_damage : float = 3.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func setup_projectile(particle_modifier : float, cur_speed_modifier : float, cur_damage_modifier : float):
	cur_speed = abs(speed * cur_speed_modifier)
	cur_damage = damage * cur_damage_modifier
