class_name BeingPosition

extends Spell

var being

func _init():
	spell_name = "Being Position"
	cost = 0
	unlocked_by_default = true
	variables = {"being" : "Being"}
	pattern = ["r", "r", "ddr"]
	description = "Returns the position of the being inputted."
	category = SpellCategory.Scouting

func spell_effect():
	if being != null:
		returns.append(StackItem.new(being.value.get_global_position()))
	return returns 
