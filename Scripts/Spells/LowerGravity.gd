class_name LowerGravity

extends Spell

var Being

func _init():
	spell_name = "Move Being"
	cost = 0
	variables = {"Being" : "Being", }

func spell_effect():
	if Being != null:
		var character_body : Player = Being.value.p as Player
		character_body.gravity = character_body.gravity / 4
		await Global.current_scene.root.get_tree().create_timer(5).timeout
		character_body.gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
	return returns 
