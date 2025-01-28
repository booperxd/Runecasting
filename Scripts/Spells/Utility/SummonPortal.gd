class_name SummonPortal

extends RuneSpell

var portal_scene : PackedScene = load("res://Scenes/Portal.tscn")

var destination : PackedScene = load("res://Scenes/Levels/pocket_dimension.tscn")

func _init():
	spell_name = "Summon Portal"
	pattern = [BloodRune.new(), AirRune.new()]
	
func spell_effect():
	var portal_instance : Portal = portal_scene.instantiate() as Portal
	portal_instance.destination_scene = destination
	var raycast : RayCast3D = RayCast3D.new()
	
	caster.add_child(raycast)
	raycast.global_position = caster.head.global_position
	
	var dir = Vector3(caster.get_direction().x, 0, caster.get_direction().z) * 5
	
	raycast.target_position = Vector3(raycast.global_position.x + dir.x, raycast.global_position.y,raycast.global_position.z  + dir.z) - raycast.global_position  
	raycast.owner = caster
	raycast.force_raycast_update()
	await Global.current_scene.get_tree().physics_frame
	Global.current_scene.add_child(portal_instance)
	if !raycast.is_colliding():
		portal_instance.global_position = Vector3(raycast.global_position.x + dir.x, raycast.global_position.y,raycast.global_position.z  + dir.z)
	else:
		portal_instance.global_position = raycast.get_collision_point()
		
	
	portal_instance.look_at(caster.global_position)
	portal_instance.rotation.x = 0
	portal_instance.rotation.z = 0
