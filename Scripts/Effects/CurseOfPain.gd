class_name CurseOfPain

extends Spell

var entity : StackItem

func _init():
	spell_name = "Curse of Pain"
	cost = 0
	variables = {"entity" : "Entity"}

func spell_effect():
	if entity != null:
		var e = entity.value as Entity
		e.add_effect(CurseEffect.new())
	return returns 
