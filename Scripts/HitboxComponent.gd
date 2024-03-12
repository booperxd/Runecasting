class_name HitboxComponent

extends Node3D

@export var hitbox_area : Area3D
@export var health_component : HealthComponent

func _on_hitbox_area_body_entered(body):
	if health_component:
		health_component.take_damage(0)
