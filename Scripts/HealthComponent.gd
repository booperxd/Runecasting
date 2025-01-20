class_name HealthComponent

extends Node

var damage_number : PackedScene = load("res://Scenes/damage_number.tscn")

@export var max_health : float
#@export var hitbox_component : HitboxComponent

var health : float
var defense : float = 1.0

func _ready():
	health = max_health


func take_damage(attack : Attack):
	health -= attack.damage
	
	var damage_instance : DamageNumber = damage_number.instantiate()
	damage_instance.text = str(attack.damage)
	get_tree().root.add_child(damage_instance)
	damage_instance.position = get_parent().global_position + Vector3(0, 2, 0)
	if health <= 0:
		die()

func heal(gained_hp):
	health += gained_hp
	if health > max_health:
		health = max_health

func die():
	owner.queue_free()


