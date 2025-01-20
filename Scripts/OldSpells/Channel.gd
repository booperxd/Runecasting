class_name Channel

extends Spell

func _init():
	spell_name = "Channel"
	pattern = ["dur", "dur"]
	description = "Start focusing, stopping spells from casting when you draw them
	\nUsed for creating custom spells to add to your spellbook.
	\nCast this again to cancel the channel and clear the stack."
	category = SpellCategory.Scouting

func spell_effect():
	returns.append(StackItem.new(SpellStop.new(false)))
	return returns
