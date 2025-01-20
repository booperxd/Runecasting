class_name Haste

extends Effect


func _init():
	effect_name = "Haste"
	effect_desc = "You are hastened. You will move faster"
	effect_duration = 5.0
	interval_timer = 0

func handle_effect():
	being.MAX_SPEED = being.S_MAX_SPEED * 2
	being.SPEED = being.S_SPEED * 2

func stop_effect():
	being.MAX_SPEED = being.S_MAX_SPEED
	being.SPEED = being.S_SPEED
	super.stop_effect()
