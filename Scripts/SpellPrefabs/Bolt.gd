class_name BoltProjectile

extends Projectile

@onready var mesh = $MeshInstance3D

func _ready():
	cur_speed = speed
	cur_damage = damage

func _physics_process(delta):
	if particles.emitting:
		move_and_collide(-transform.basis.z * delta * cur_speed)
	else:
		pass


func _on_timer_timeout():
	queue_free()


func _on_self_destruct_timer_timeout():
	queue_free()


func _on_area_3d_area_entered(area):
	set_deferred("monitoring", false)
	particles.emitting = false
	particle_timer.start()
	selfdestruct_timer.stop()
	mesh.visible = false
	if area is HitboxComponent:	
		
		var hitbox : HitboxComponent = area
		var attack : Attack = Attack.new(cur_damage)
		hitbox.damage(attack)
		hitbox.apply_effect(FireEffect.new())



func _on_area_3d_body_entered(body):
	set_deferred("monitoring", false)
	particles.emitting = false
	mesh.visible = false
	particle_timer.start()
	selfdestruct_timer.stop()
