class_name GoblinHealthComponent

extends HealthComponent

signal on_goblin_hit

func take_damage(attack : Attack):
	health -= attack.damage
	var damage_instance : DamageNumber = damage_number.instantiate()
	damage_instance.text = str(attack.damage)
	get_tree().root.add_child(damage_instance)
	damage_instance.position = get_parent().global_position + Vector3(0, 2, 0)
	on_goblin_hit.emit()
	if health <= 0:
		die()

func die():
	Global.enemy_beat_in_room.emit()
	super.die()
	
