class_name MeteorSpell

extends RuneSpell

var meteor : PackedScene = load("res://Scenes/SpellPrefabs/meteor.tscn")

func _init():
	spell_name = "Meteor"
	pattern = [FireRune.new().rune_name, FireRune.new().rune_name, FireRune.new().rune_name]

func spell_effect():
	var instance : MeteorObject = meteor.instantiate()
	var raycast : RayCast3D = RayCast3D.new()
	
	caster.add_child(raycast)
	raycast.global_position = caster.head.global_position
	raycast.target_position = Vector3(raycast.global_position.x, raycast.global_position.y + 20,raycast.global_position.z) - raycast.global_position  
	raycast.owner = caster
	raycast.force_raycast_update()
	await Global.current_scene.get_tree().physics_frame
	if !raycast.is_colliding():
		instance.global_position = raycast.global_position + Vector3(0,20,0)
	else:
		instance.global_position = raycast.get_collision_point()
		
	Global.current_scene.add_child(instance)
	
	instance.direction = caster.get_direction()
	#raycast.queue_free()

