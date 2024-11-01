class_name PoisonEffect

extends Effect

var damage = 1

func _init():
	effect_name = "Poison"
	effect_desc = "You have been mildly poisoned. Take damage periodically."
	effect_duration = 5.0
	interval_timer = 1.0
	particle_effect = load("res://Scenes/Effects/PoisonEffectParticles.tscn")

func handle_effect():
	var attack = Attack.new(damage)
	being.hitbox_component.damage(attack)
