extends Area3D

@export var starting_size : float
@export var growth_rate : float = 0.05
@onready var col_shape : CollisionShape3D = $CollisionShape3D
@onready var particles : GPUParticles3D = $FrostRing

func _ready():
	col_shape.get_shape().radius = starting_size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	col_shape.get_shape().radius += growth_rate
	#var process_material : ParticleProcessMaterial = particles.process_material as ParticleProcessMaterial
	#process_material.emission_ring_radius = col_shape.get_shape().radius
	#particles.process_material = process_material

func _on_self_destruct_timer_timeout():
	queue_free()


func _on_area_entered(area):
	if area is HitboxComponent:	
		var hitbox : HitboxComponent = area
		hitbox.apply_effect(ChilledEffect.new())
