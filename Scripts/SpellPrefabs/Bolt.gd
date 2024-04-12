extends Area3D

@export var speed : float = 20

@onready var particles : GPUParticles3D = $BoltEffect
@onready var particle_timer : Timer = $DetonationTimer
@onready var selfdestruct_timer : Timer = $SelfDestructTimer

func _process(delta):
	position += -global_transform.basis.z * speed * delta


func _on_body_entered(body):
	set_deferred("monitoring", false)
	particles.emitting = false
	particle_timer.start()
	selfdestruct_timer.stop()


func _on_timer_timeout():
	queue_free()


func _on_area_entered(area):
	set_deferred("monitoring", false)
	particles.emitting = false
	particle_timer.start()
	selfdestruct_timer.stop()
	if area is HitboxComponent:
		var hitbox : HitboxComponent = area
		var attack : Attack = Attack.new()
		attack.damage = 5
		hitbox.damage(attack)


func _on_self_destruct_timer_timeout():
	queue_free()
