class_name LightningBallProjectile

extends Projectile

@onready var damage_per_tick : float = 0.5
@onready var flicker_timer : Timer = $DamageFlickerTimer

func _ready():
	cur_speed = speed
	cur_damage = damage

func _physics_process(delta):
	move_and_collide(-transform.basis.z * delta * cur_speed)


func _on_self_destruct_timer_timeout():
	queue_free()


func _on_area_3d_area_entered(area):
	cur_speed = speed / 8.0


func _on_damage_flicker_timer_timeout():
	for area in area_collision.get_overlapping_areas():
		if area is HitboxComponent:
			var attack : Attack = Attack.new(damage_per_tick)
			area.damage(attack)
			area.apply_effect(ChilledEffect.new())
