class_name SaveData

extends Resource

@export var last_scene : PackedScene
@export var player_health : int
@export var player_notebook : Array[Line2D]


func save(scene : Node):
	last_scene = PackedScene.new()
	last_scene.pack(scene)
	ResourceSaver.save(self, "user://SaveData.tres")

static func load_or_create() -> SaveData:
	var res : SaveData = load("user://SaveData.tres") as SaveData
	if !res:
		res = SaveData.new()
	return res

static func delete() -> SaveData:
	var res : SaveData = load("user://SaveData.tres") as SaveData
	if !res:
		return SaveData.new()
	DirAccess.remove_absolute("user://SaveData.tres")
	return SaveData.new()
