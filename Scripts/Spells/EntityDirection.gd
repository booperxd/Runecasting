class_name BeingDirection

extends Spell

var being

func _init():
	spell_name = "Being Direction"
	cost = 0
	unlocked_by_default = true
	variables = {"being" : "Being"}
	pattern = ["r", "r", "dur"]
	description = "Returns the direction of the Being inputted."
	category = SpellCategory.Scouting

func spell_effect():
	if being != null:
		returns.append(StackItem.new(being.value.head.get_node("Camera3D").get_global_transform().basis.z * -1))
	return returns 
