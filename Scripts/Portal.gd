class_name Portal

extends Area3D

@export var destination_scene : PackedScene

var can_teleport : bool = false


func _process(delta):
	if Input.is_action_just_pressed("interact") and can_teleport and destination_scene != null:
		var scene = PackedScene.new()
		scene.pack(get_tree().current_scene)
		Global.player.player_spells.save()
		Global.save_data.save(get_tree().get_current_scene())
		Global.previous_scene = scene
		get_tree().change_scene_to_packed(destination_scene)

func _on_body_entered(body):
	if body.is_in_group("player"):
		Global.interactable_near.emit(Global.Interactables.Portal)
		can_teleport = true
		


func _on_body_exited(body):
	if body.is_in_group("player"):
		Global.interactable_near.emit(Global.Interactables.None)
		can_teleport = false
