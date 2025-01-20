class_name BloodParticles

extends Node3D

@onready var blood_particles : GPUParticles3D = $BloodParticles

var dir : Vector3

func _ready():
	if dir != null and dir != Vector3.ZERO:
		blood_particles.process_material.direction = dir


func _on_timer_timeout():
	queue_free()
