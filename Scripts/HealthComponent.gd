class_name HealthComponent

extends Node

@export var max_health : int
#@export var hitbox_component : HitboxComponent

var health : int

func _ready():
	health = max_health

func take_damage(attack : Attack):
	health -= attack.damage
	print("took damage")
	if health <= 0:
		die()

func die():
	owner.queue_free()
