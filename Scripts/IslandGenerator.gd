@tool

extends MeshInstance3D

@export var noise_offset = 15
@export var x_size = 30
@export var z_size = 20
@export var island_depth = 5.0
@export var height_limit : float

@export var update : bool = false
@export var clear_vert_vis : bool = false

func _ready():
	generate_terrain()
	
func generate_terrain():
	var a_mesh:ArrayMesh
	var surface_tool = SurfaceTool.new()
	var noise = FastNoiseLite.new()
	#noise.seed = randi()
	noise.noise_type = FastNoiseLite.TYPE_PERLIN
	noise.frequency = 0.1
	
	surface_tool.begin(Mesh.PRIMITIVE_TRIANGLES)
	


	for z in range(z_size + 1):
		for x in range(x_size + 1):
			
			
			var y = noise.get_noise_2d(x * 0.2, z * 0.2) * (noise_offset)
			
			var uv = Vector2()
			uv.x = inverse_lerp(0, x_size, x)
			uv.y = inverse_lerp(0, z_size, z)
			surface_tool.set_uv(uv)
			surface_tool.add_vertex(Vector3(x, y, z))
			#draw_spheres(Vector3(x,y,z))

	var vert=0
	for z in z_size:
		for x in x_size:
			surface_tool.add_index(vert)
			surface_tool.add_index(vert + 1)
			surface_tool.add_index(vert + x_size + 1)
			surface_tool.add_index(vert + x_size + 1)
			surface_tool.add_index(vert + 1)
			surface_tool.add_index(vert + x_size + 2)
			
			vert += 1
		vert += 1
			
	surface_tool.generate_normals()
	a_mesh = surface_tool.commit()
	
	
	
	mesh = a_mesh
	
#Debug stuff
func draw_spheres(pos : Vector3):
	var i = MeshInstance3D.new()
	add_child(i)
	var sphere = SphereMesh.new()
	sphere.radius = .1
	sphere.height = .2
	i.position = pos
	i.mesh = sphere

func is_edge(x, z) -> bool:
	return x == 0 and z == 0

func _process(delta):
	if update:
		generate_terrain()
		update = false
		
	if clear_vert_vis:
		for i in get_children():
			i.queue_free()

func f_min(arr : Array):
	var lowest = arr[0]
	for a in arr:
		if a < lowest:
			lowest = a
	return lowest
	
	
func f_max(arr : Array):
	var highest = arr[0]
	for a in arr:
		if a > highest:
			highest = a
	return highest
