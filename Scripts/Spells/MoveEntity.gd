class_name MoveEntity

extends Spell

var entity
var distance

func _init():
	spell_name = "Lesser Blink"
	cost = 0
	variables = {"distance" : "int", "entity" : "Entity", }

func spell_effect():
	if entity != null and distance != null:
		var character_body : CharacterBody3D = entity.value.p
		var direction = character_body.get_node("Camera3D").get_global_transform().basis.z * -1
		distance.value = clamp(distance.value, 0, 10)
		character_body.position += (direction * distance.value)
	return returns 
