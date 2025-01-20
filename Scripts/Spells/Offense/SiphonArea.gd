extends RuneSpell

var radius : float = 6.0 

var attack_damage : float = 4.0

var blood_particles : PackedScene = load("res://Scenes/Effects/blood_particles.tscn")

func _init():
	spell_name = "Siphon Area"
	pattern = [BloodRune.new().rune_name, 
	BloodRune.new().rune_name, 
	BloodRune.new().rune_name,
	RadialRune.new().rune_name]

func spell_effect():
	var area = Area3D.new()
	area.set_collision_layer_value(4, true)
	area.set_collision_mask_value(5, true) 
	Global.current_scene.add_child(area)
	area.global_position = caster.head.global_position
	var col_shape : CollisionShape3D = CollisionShape3D.new()
	col_shape.shape = SphereShape3D.new()
	col_shape.shape.radius = radius
	
	area.add_child(col_shape)
	col_shape.global_position = caster.head.global_position
	await Global.current_scene.get_tree().physics_frame
	
	var areas = area.get_overlapping_areas()

	for col_area in areas:
		if col_area is HitboxComponent:
			var attack : Attack = Attack.new(attack_damage)
			col_area.damage(attack)
			
			caster.health_component.heal(attack_damage / 2)
			
			var instance : BloodParticles = blood_particles.instantiate()
			#var dir : Vector3 = (caster.head.position - col_area.global_position).normalized()
			#instance.dir = dir
			
			Global.current_scene.add_child(instance)
			instance.global_position = col_area.global_position + Vector3(0, 1, 0)
			
			
	area.queue_free()
	
