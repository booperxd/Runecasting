class_name Entity

extends Node3D

var p

func _ready():
	await(owner.ready)
	p = owner

