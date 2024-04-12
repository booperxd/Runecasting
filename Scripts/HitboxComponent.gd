class_name HitboxComponent

extends Area3D

@export var hitbox_area : Area3D
@export var health_component : HealthComponent

func damage(attack : Attack):
	if health_component:
		health_component.take_damage(attack)
