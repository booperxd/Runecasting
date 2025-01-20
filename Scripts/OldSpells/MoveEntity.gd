class_name MoveBeing

extends Spell

var Being
var distance

func _init():
	spell_name = "Lesser Blink"
	cost = 0
	variables = {"distance" : "int", "Being" : "Being", }

func spell_effect():
	if Being != null and distance != null:
		var character_body : CharacterBody3D = Being.value.p
		var direction = character_body.get_node("Camera3D").get_global_transform().basis.z * -1
		distance.value = clamp(distance.value, 0, 10)
		character_body.position += (direction * distance.value)
	return returns 
