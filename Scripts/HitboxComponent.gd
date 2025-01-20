class_name HitboxComponent

extends Area3D

@export var hitbox_area : Area3D
@export var health_component : HealthComponent

func damage(attack : Attack):
	if health_component:
		health_component.take_damage(attack)

func apply_effect(effect : Effect):
	if get_parent() is Being:
		var being : Being = get_parent() as Being
		being.add_effect(effect)

func remove_effect(effect : Effect):
	pass
