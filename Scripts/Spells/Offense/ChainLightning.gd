class_name ChainLightning

extends RuneSpell

#var lighting_vfx : PackedScene = load("res://Scenes/SpellPrefabs/lightning_bolt.tscn")

var hit_targets : Array[HitboxComponent]
var damage : float = 10.0
var chain_radius : float = 5.0

func _init():
	spell_name = "Chain Lightning"
	pattern = [ElectricRune.new(), ProjectileRune.new(), ElectricRune.new(), RadialRune.new()]

func spell_effect():
	hit_targets.clear()
	
	var raycast : RayCast3D = RayCast3D.new()
	var lightning : Lightning3DSimple = Lightning3DSimple.new()
	lightning.width = 1.5
	caster.add_child(lightning)
	lightning.global_position = Vector3.ZERO
	lightning.add_point(caster.global_position)
	
	
	raycast.set_collision_mask_value(5, true)
	raycast.collide_with_areas = true
	caster.add_child(raycast)
	raycast.global_position = caster.head.global_position
	raycast.target_position = (caster.get_direction() * 20)
	raycast.owner = caster
	
	raycast.force_raycast_update()
	await Global.current_scene.get_tree().physics_frame
	
	if raycast.is_colliding() and raycast.get_collider() is HitboxComponent:
		var enemy = raycast.get_collider() as HitboxComponent
		var attack : Attack = Attack.new(damage)
		enemy.damage(attack)
		hit_targets.append(enemy)
		lightning.add_point(enemy.global_position)
		try_jump_lightning(enemy.global_position, lightning)
	else:
		lightning.add_point(caster.head.global_position + (caster.get_direction() * 20))
	lightning.create_lightning()
	raycast.queue_free()
	await Global.current_scene.get_tree().create_timer(.15).timeout
	lightning.queue_free()

func try_jump_lightning(pos : Vector3, lightning : Lightning3DSimple):
	var area = Area3D.new()
	area.set_collision_mask_value(1, false) 
	area.set_collision_mask_value(5, true) 
	Global.current_scene.add_child(area)
	area.global_position = caster.head.global_position
	var col_shape : CollisionShape3D = CollisionShape3D.new()
	col_shape.shape = SphereShape3D.new()
	col_shape.shape.radius = chain_radius
	
	area.add_child(col_shape)
	col_shape.global_position = pos
	await Global.current_scene.get_tree().physics_frame
	
	var areas = area.get_overlapping_areas()
	
	var closest_enemy : HitboxComponent
	
	for enemy in areas:
		if hit_targets.has(enemy):
			continue
		if closest_enemy == null or pos.distance_to(enemy.global_position) < pos.distance_to(closest_enemy.global_position):
			closest_enemy = enemy
	if closest_enemy != null:
		var attack : Attack = Attack.new(damage)
		closest_enemy.damage(attack)
		hit_targets.append(closest_enemy)
		
		lightning.add_point(closest_enemy.global_position)
		
		try_jump_lightning(closest_enemy.global_position, lightning)
