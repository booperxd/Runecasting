class_name SaveData

extends Resource

@export var last_scene : PackedScene
@export var player_health : int

var player_notebook : Line2D
@export var packed_notebook : PackedScene


func save(scene : Node):
	last_scene = PackedScene.new()
	last_scene.pack(scene)
	packed_notebook = PackedScene.new()
	if player_notebook != null:
		for c in player_notebook.get_children():
			c.set_owner(player_notebook)
	packed_notebook.pack(player_notebook)
	ResourceSaver.save(self, "user://SaveData.tres")

func unpack_notebook() -> Line2D:
	return packed_notebook.instantiate() as Line2D
	
static func load_or_create() -> SaveData:
	var res : SaveData = load("user://SaveData.tres") as SaveData
	if !res:
		res = SaveData.new()
	if res.packed_notebook != null:
		res.player_notebook = res.packed_notebook.instantiate() as Line2D
	return res

static func delete() -> SaveData:
	var res : SaveData = load("user://SaveData.tres") as SaveData
	if !res:
		return SaveData.new()
	DirAccess.remove_absolute("user://SaveData.tres")
	return SaveData.new()
