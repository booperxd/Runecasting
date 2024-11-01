class_name Effect

extends Node

var being : Being
@export var effect_name : String
@export var effect_desc : String
@export var interval_timer : float = 1.0
@export var particle_effect : PackedScene

var effect_duration : float

func _ready():
	var dur_timer : Timer = Timer.new()
	var effect_timer : Timer = Timer.new()
	add_child(dur_timer)
	add_child(effect_timer)
	dur_timer.one_shot = true
	dur_timer.wait_time = effect_duration
	
	effect_timer.one_shot = false
	effect_timer.wait_time = interval_timer
	
	
	dur_timer.timeout.connect(on_dur_timer_timeout)
	effect_timer.timeout.connect(on_effect_timer_timeout)
	
	dur_timer.start()
	effect_timer.start()
	
	if (particle_effect != null):
		var particle_instance : GPUParticles3D = particle_effect.instantiate()
		being.add_child(particle_instance)
		particle_instance.lifetime = effect_duration
		particle_instance.one_shot = true

func start_effect():
	pass

func handle_effect():
	pass

func on_effect_timer_timeout():
	handle_effect()

func on_dur_timer_timeout():
	stop_effect()

func stop_effect():
	queue_free()
