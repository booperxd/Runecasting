class_name ExplosionEffect

extends Area3D
@onready var smoke_particles : GPUParticles3D = $SmokeParticles
var terrain : VoxelTerrain

var strength : int = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	terrain = Global.current_scene.get_node("VoxelTerrain")
	smoke_particles.one_shot = true
	strength = clamp(strength, 1, 10)
	if strength >= 5:
		destroy_terrain()

func destroy_terrain():
	var vt = terrain.get_voxel_tool()
	
	vt.mode = VoxelTool.MODE_REMOVE
	vt.value = 1

	vt.do_sphere(global_transform.origin, float(strength)) 

func _on_damage_timer_timeout():
	self.monitoring = false
