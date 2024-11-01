extends Node3D

@onready var portal : Portal = $Portal
@export var summon_position : Vector3 = Vector3(13, 60, 0)

func _ready():
	if Global.previous_scene != null:
		portal.destination_scene = Global.previous_scene
	else:
		portal.destination_scene = load("res://Scenes/Levels/cave_dungeon.tscn")


func _on_boundary_box_body_entered(body):
	if body is Player:
		body.position = summon_position
