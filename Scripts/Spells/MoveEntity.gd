class_name MoveEntity

extends Spell

var entity
var direction

func _init():
	spell_name = "Move Entity"
	cost = 0
	variables = {"direction" : "Vector3", "entity" : "Entity", }

func spell_effect():
	if entity != null and direction != null:
		var character_body : CharacterBody3D = entity.value.p
		character_body.position -= direction.value
	return returns 
