extends Camera3D


func _on_load_button_pressed():
	pass # Replace with function body.


func _on_quit_button_pressed():
	get_tree().change_scene_to_packed(load("res://Scenes/MainMenuEnvironment.tscn"))
