class_name SpellData

extends Resource

var spells : Array

func _init():
	var script_names = get_all_spell_scripts("res://Scripts/Spells/")
	for script in script_names:
		var path = "res://Scripts/Spells/" + script
		spells.append(ResourceLoader.load(path).new())

func get_all_spell_scripts(path: String) -> Array[String]:  
	var file_paths: Array[String] = []  
	var dir = DirAccess.open(path)  
	dir.list_dir_begin()  
	var file_name = dir.get_next()  
	while file_name != "":  
		var file_path = path + "/" + file_name  
		if dir.current_is_dir():  
			file_paths += get_all_spell_scripts(file_path)  
		elif '.gd' in file_name:  
			file_paths.append(file_name)  
		file_name = dir.get_next()  
	return file_paths