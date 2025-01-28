class_name HumanCannonballSpell

extends RuneSpell


func _init():
	spell_name = "Human Cannonball"
	pattern = [GravityRune.new(), GravityRune.new(), SelfRune.new(), ProjectileRune.new()]
	
func spell_effect():
	if caster is RuneWizard:
		var player : RuneWizard = caster as RuneWizard
		player.state_machine.transition("RuneWizardGroundPound")
