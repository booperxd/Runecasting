class_name SpawnPoint

extends Node3D

var room_name : String

@export var func_godot_properties : Dictionary

func _ready():
	room_name = func_godot_properties["room_name"]

func spawn_being(being_scene : PackedScene):
	var instance = being_scene.instantiate()
	if instance is Being:
		Global.current_scene.add_child(instance)
		instance.position = global_position
		
