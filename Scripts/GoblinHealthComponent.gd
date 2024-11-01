class_name GoblinHealthComponent

extends HealthComponent

signal on_goblin_hit

func take_damage(attack : Attack):
	health -= attack.damage
	on_goblin_hit.emit()
	if health <= 0:
		die()
