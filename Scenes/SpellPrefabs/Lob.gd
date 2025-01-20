class_name LobProjectile

extends Projectile

var explosion : PackedScene = load("res://Scenes/SpellPrefabs/Explosion.tscn")
@onready var grav_timer : Timer = $GravityTimer

func _ready():
	particles.draw_pass_1.surface_set_material(0, load("res://Material/ArcaneMaterial.tres"))
	
	if (element is FireElement):
		particles.draw_pass_1.surface_set_material(0, load("res://Material/FireMaterial.tres"))
	super._ready()



func _physics_process(delta):
#	velocity.x = (-global_transform.basis.z * cur_speed * delta).x
#	velocity.z = (-global_transform.basis.z * cur_speed * delta).z
	
	if grav_timer.is_stopped():
		velocity.x = (-global_transform.basis.z * cur_speed * delta).x
		velocity.z = (-global_transform.basis.z * cur_speed * delta).z
		velocity.y -= (gravity / 3.0) * delta
	else:
		velocity = -global_transform.basis.z * cur_speed * delta
	move_and_slide()


func summon_explosion():
	var explosion_instance : ExplosionEffect = explosion.instantiate()
	
	get_tree().root.add_child(explosion_instance)
	explosion_instance.position = position
	queue_free()

func _on_detonation_timer_timeout():
	summon_explosion()


func _on_self_destruct_timer_timeout():
	summon_explosion()


func _on_area_3d_area_entered(area):
	set_deferred("monitoring", false)

	
	summon_explosion()


func _on_area_3d_body_entered(body):
	set_deferred("monitoring", false)

	summon_explosion()
