class_name VineObject

extends Area3D

@onready var ground_check : RayCast3D = $GroundCheck

func _ready():
	await get_tree().create_timer(0.05).timeout
	if ground_check.is_colliding():
		position = ground_check.get_collision_point() + Vector3(0, 3, 0)

func _on_body_entered(body):
	if body is Player:
		body.on_ladder = true


func _on_body_exited(body):
	if body is Player:
		body.on_ladder = false
