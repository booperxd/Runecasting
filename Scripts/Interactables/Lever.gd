extends Area3D

signal trigger()

var distance : float = 5
var in_range : bool = false

func _process(delta):
	if Input.is_action_just_pressed("interact") and in_range:
		trigger.emit()


func _on_body_entered(body):
	Global.interactable_near.emit(Global.Interactables.Lever)
	in_range = true
		


func _on_body_exited(body):
	Global.interactable_near.emit(Global.Interactables.None)
	in_range = false
