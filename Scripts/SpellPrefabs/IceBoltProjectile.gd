class_name IceBoltProjectile

extends Projectile


func _ready():
	cur_speed = speed
	cur_damage = damage

func _physics_process(delta):
	velocity = -(global_transform.basis.z * cur_speed * delta)
	move_and_slide()


func _on_self_destruct_timer_timeout():
	queue_free()


func _on_area_3d_area_entered(area):
	set_deferred("monitoring", false)
	particles.emitting = false
	particle_timer.start()
	selfdestruct_timer.stop()
	if area is HitboxComponent:	
		var hitbox : HitboxComponent = area
		var attack : Attack = Attack.new(cur_damage)
		hitbox.damage(attack)



func _on_area_3d_body_entered(body):
	set_deferred("monitoring", false)
	particles.emitting = false
	particle_timer.start()
	selfdestruct_timer.stop()


func _on_detonation_timer_timeout():
	queue_free()
