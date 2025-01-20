class_name FireEffect

extends Effect

var damage = 1

func _init():
	effect_name = "On Fire"
	effect_desc = "You\'re on fire! You will take periodic damage while engulfed in flames"
	effect_duration = 3.0
	interval_timer = .5
	particle_effect = load("res://Scenes/Effects/FireEffectParticles.tscn")

func handle_effect():
	var attack = Attack.new(damage)
	being.hitbox_component.damage(attack)
