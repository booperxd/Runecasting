class_name LowGravity

extends Effect


func _init():
	effect_name = "Low Gravity"
	effect_desc = "The magnetic fields around you have been altered. The effect of gravity has been reduced."
	effect_duration = 4.0
	interval_timer = 0


func handle_effect():
	being.gravity = being.START_GRAVITY / 3.0

func stop_effect():
	being.gravity = being.START_GRAVITY
	super.stop_effect()
