extends Spell

var Being : StackItem
var direction : StackItem

func _init():
	spell_name = "Force"
	cost = 0
	unlocked_by_default = true
	pattern = ["ddr", "ddr", "ddl", "ddl"]
	description = "Now YOU can be the projectile. Pushes an Being in a direction."
	variables = {"Being" : "Being", "direction" : "Vector3"}
	category = SpellCategory.Projectile

func spell_effect():
	if Being != null and Being.value is Being and direction != null and direction.value is Vector3:
		var e : Being = Being.value
		if e.owner is CharacterBody3D:
			e.owner.velocity = (direction.value * 10)
	else:
		returns.append(StackItem.new(0))
	return returns
