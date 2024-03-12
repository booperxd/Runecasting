class_name CurseEffect

extends Effect

var ticks_remaining
var damage = 1
var time_between_ticks = 1.0


func _init():
	effect_name = "Curse of Pain"
	effect_name = "Deals 5 damage over 5 seconds"
	effect_duration = 5.0
	ticks_remaining = int(effect_duration)
	
func start_effect():
	var timer := Timer.new()
	timer.wait_time = time_between_ticks
	timer.autostart = true
	var effect_instance = CurseEffect.new()
	effect_instance.add_child(timer)
	timer.connect("timeout", handle_effect)
	return effect_instance
	
func handle_effect():
	if entity != null:
		entity.health_component.take_damage(1)
		ticks_remaining-=1
		if ticks_remaining <= 0:
			stop_effect()
