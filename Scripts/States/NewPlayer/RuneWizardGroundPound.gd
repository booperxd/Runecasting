class_name RuneWizardGroundPound

extends RuneWizardState

var ground_pound_particles : PackedScene = load("res://Scenes/Effects/rubble_particles.tscn")

var starting_pos : Vector3
var base_damage : float = 7.0
var scaling_damage : float = 0.2


func enter():
	starting_pos= p.global_position


func update(delta):
	if not p.is_on_floor():
		p.velocity.y = -(p.gravity * 2)
		var direction = (p.head.transform.basis * Vector3(p.input_dir.x, 0, p.input_dir.y)).normalized()	
		p.velocity.x = lerp(p.velocity.x,direction.x * p.SPEED, delta * 8.0)
		p.velocity.z = lerp(p.velocity.z,direction.z * p.SPEED, delta * 8.0)
	else:
		sm.transition("RuneWizardIdle")

func exit():
	var final_damage : float = base_damage + ((starting_pos - p.global_position).length_squared() * scaling_damage)
	var damage_area : Area3D = Area3D.new()
	damage_area.set_collision_layer_value(1, false)
	damage_area.set_collision_layer_value(4, true)
	
	damage_area.set_collision_mask_value(1, false)
	damage_area.set_collision_mask_value(5, true)
	Global.current_scene.add_child(damage_area)
	damage_area.global_position = p.global_position
	
	var collision_shape : CollisionShape3D = CollisionShape3D.new()
	collision_shape.shape = SphereShape3D.new()
	collision_shape.shape.radius = 4.5
	damage_area.add_child(collision_shape)
	collision_shape.global_position = damage_area.global_position
	
	
	await Global.current_scene.get_tree().physics_frame
	
	for area in damage_area.get_overlapping_areas():
		if area is HitboxComponent:
			var attack : Attack = Attack.new(final_damage)
			area.damage(attack)
	
	var particles_instance : GPUParticles3D = ground_pound_particles.instantiate()
	Global.current_scene.add_child(particles_instance)
	particles_instance.global_position = p.head.global_position
	particles_instance.emitting = true
	
	damage_area.queue_free()
