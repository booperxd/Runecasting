class_name ChilledEffect

extends Effect

func _init():
	effect_name = "Chilled"
	effect_desc = "Your muscles are frozen in chunks of ice. Your movement speed is greatly reduced"
	effect_duration = 3.0
	interval_timer = 0


func handle_effect():
	being.MAX_SPEED = being.S_MAX_SPEED / 3.0
	being.SPEED = being.S_SPEED / 3.0

func stop_effect():
	being.MAX_SPEED = being.S_MAX_SPEED
	being.SPEED = being.S_SPEED
	super.stop_effect()
