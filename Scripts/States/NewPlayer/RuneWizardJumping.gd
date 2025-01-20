class_name RuneWizardJumping

extends RuneWizardState


func enter():
	p.velocity.y = p.JUMP_VELOCITY
	sm.transition("RuneWizardIdle")
