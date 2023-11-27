class_name EntityDirection

extends Spell

var entity

func _init():
	spell_name = "Entity Direction"
	cost = 0
	variables = {"entity" : "Entity"}

func spell_effect():
	if entity != null:
		returns.append(StackItem.new(entity.value.p.get_node("Camera3D").get_global_transform().basis.z))
	return returns 
