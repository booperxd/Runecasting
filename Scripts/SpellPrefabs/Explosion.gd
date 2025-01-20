class_name ExplosionEffect

extends Area3D
@onready var smoke_particles : GPUParticles3D = $SmokeParticles

var strength : int = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	smoke_particles.one_shot = true
	strength = clamp(strength, 1, 10)
	if strength >= 5:
		destroy_terrain()

func destroy_terrain():
	pass

func _on_damage_timer_timeout():
	self.monitoring = false


func _on_area_entered(area):
	if area is HitboxComponent:	
		var hitbox : HitboxComponent = area
		var attack : Attack = Attack.new(strength * 2)
		hitbox.damage(attack)

