class_name PlayerJumping

extends PlayerState


func enter():
	p.velocity.y = p.JUMP_VELOCITY
	sm.transition("PlayerIdle")
