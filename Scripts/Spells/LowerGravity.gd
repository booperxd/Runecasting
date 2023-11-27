class_name LowerGravity

extends Spell

var entity

func _init():
	spell_name = "Move Entity"
	cost = 0
	variables = {"entity" : "Entity", }

func spell_effect():
	if entity != null:
		var character_body : Player = entity.value.p as Player
		character_body.gravity = character_body.gravity / 4
		await Global.current_scene.root.get_tree().create_timer(5).timeout
		character_body.gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
	return returns 
