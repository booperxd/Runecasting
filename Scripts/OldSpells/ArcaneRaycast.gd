class_name ArcaneRaycast

extends Spell

var Being

func _init():
	spell_name = "Arcane Raycast"
	cost = 0
	variables = {"Being" : "Being"}
	pattern = ["r", "r", "dul", "d", "dur"]
	description = "Shoots a raycast from the center of the Being's camera.
			\nReturns the first Being or position of the raycast's collision."
	category = SpellCategory.Scouting

func spell_effect():
	if Being != null:
		var character_body : CharacterBody3D = Being.value.p
		var camera : Camera3D = character_body.get_node("Head").get_node("Camera3D")
		if camera != null:
			var raycast : RayCast3D = camera.get_node("RayCast3D")
			if raycast != null:
				if raycast.is_colliding():
					var col = raycast.get_collider()
					if col is HitboxComponent:
						returns.append(StackItem.new(col.owner.get_node("Being")))
					elif col.is_in_group("gridmap"):
						var gm = col as GridMap
						returns.append(StackItem.new(raycast.get_collision_point()))
					else:
						returns.append(StackItem.new(raycast.get_collision_point()))
	return returns 
