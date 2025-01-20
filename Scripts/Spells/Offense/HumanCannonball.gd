class_name HumanCannonballSpell

extends RuneSpell


func _init():
	spell_name = "Human Cannonball"
	pattern = [GravityRune.new().rune_name, GravityRune.new().rune_name, SelfRune.new().rune_name, ProjectileRune.new().rune_name]
	
func spell_effect():
	if caster is RuneWizard:
		var player : RuneWizard = caster as RuneWizard
		player.state_machine.transition("RuneWizardGroundPound")
