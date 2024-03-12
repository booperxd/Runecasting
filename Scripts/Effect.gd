class_name Effect

extends Node

var entity : Entity
var effect_name : String
var effect_desc : String

var effect_duration : float

func start_effect():
	return null

func handle_effect():
	pass
	
func stop_effect():
	queue_free()
