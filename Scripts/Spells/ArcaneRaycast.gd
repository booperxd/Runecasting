class_name ArcaneRaycast

extends Spell

var entity

func _init():
	spell_name = "Arcane Raycast"
	cost = 0
	variables = {"entity" : "Entity"}
	pattern = ["r", "r", "dul", "d", "dur"]
	description = "Shoots a raycast from the center of the entity's camera.
			\nReturns the first entity or position of the raycast's collision."
	category = SpellCategory.Scouting

func spell_effect():
	if entity != null:
		var character_body : CharacterBody3D = entity.value.p
		var camera : Camera3D = character_body.get_node("Head").get_node("Camera3D")
		if camera != null:
			var raycast : RayCast3D = camera.get_node("RayCast3D")
			if raycast != null:
				if raycast.is_colliding():
					var col = raycast.get_collider()
					if col.is_in_group("entity"):
						returns.append(StackItem.new(col.get_node("Entity")))
					elif col.is_in_group("gridmap"):
						var gm = col as GridMap
						returns.append(StackItem.new(raycast.get_collision_point()))
					else:
						returns.append(StackItem.new(raycast.get_collision_point()))
	return returns 
