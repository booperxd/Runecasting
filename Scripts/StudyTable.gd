extends Area3D

var type : Global.Interactables = Global.Interactables.StudyTable

func _on_body_entered(body):
	if body.is_in_group("player"):
		Global.interactable_near.emit(type)


func _on_body_exited(body):
	if body.is_in_group("player"):
		Global.interactable_near.emit(Global.Interactables.None)
