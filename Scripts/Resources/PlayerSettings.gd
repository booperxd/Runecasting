class_name PlayerSettings

extends Resource

#Settings saving stuff
@export_range(0.0, 0.2, 0.01) var bob_amp : float = 0.08
@export_range(0.001, 1.0, 0.001) var sens : float = 0.001

func save():
	ResourceSaver.save(self, "user://PlayerSettings.tres")

static func load_or_create() -> PlayerSettings:
	var res : PlayerSettings = load("user://PlayerSettings.tres") as PlayerSettings
	if !res:
		res = PlayerSettings.new()
	return res
