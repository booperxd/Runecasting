class_name Zap

extends RuneSpell

#var lighting_vfx : PackedScene = load("res://Scenes/SpellPrefabs/lightning_bolt.tscn")

var damage : float = 5.0

func _init():
	spell_name = "Zap"
	pattern = [ElectricRune.new(), ElectricRune.new()]

func spell_effect():
	var raycast : RayCast3D = RayCast3D.new()
	var lightning : Lightning3DSimple = Lightning3DSimple.new()
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
		lightning.add_point(enemy.global_position)
	else:
		lightning.add_point(caster.head.global_position + (caster.get_direction() * 20))
	lightning.create_lightning()
	raycast.queue_free()
	await Global.current_scene.get_tree().create_timer(.15).timeout
	lightning.queue_free()
