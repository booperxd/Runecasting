extends Spell

func _init():
	spell_name = "Conjure Element : Nature"
	cost = 0
	unlocked_by_default = true
	pattern = ["dur", "u", "dur", "r", "d", "ddl", "l"]
	description = "Conjure the element of nature!"
	category = SpellCategory.Elements

func spell_effect():
	returns.append(StackItem.new(NatureElement.new()))
	return returns
