class_name Being

extends Node3D

var p
var head : Node3D

var health_component : HealthComponent
var hitbox_component : HitboxComponent

var effects : Array

func _ready():
	await(owner.ready)
	p = owner
	head = p.get_node("Head")
	if get_node("HealthComponent") != null:
		health_component = get_node("HealthComponent") as HealthComponent
	if get_node("HitboxComponent") != null:
		hitbox_component = get_node("HitboxComponent") as HitboxComponent

func add_effect(effect):
	effects.append(effect)
	effect.being = self as Being
	add_child(effect)
