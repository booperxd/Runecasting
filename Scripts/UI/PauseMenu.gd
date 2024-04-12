extends Control

@onready var button_container : VBoxContainer = $ButtonContainer
@onready var settings_panel : PanelContainer = $Panel

@onready var sens_slider : HSlider = $Panel/SettingsContainer/SensitivityContainer/SensSlider
@onready var bob_slider : HSlider = $Panel/SettingsContainer/BobAmpContainer/BobSlider

var terrain : VoxelTerrain

func _ready():
	await(owner.ready)
	terrain = Global.current_scene.get_node("VoxelTerrain")
	button_container.visible = true
	settings_panel.visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	sens_slider.value = Global.player_settings.sens
	bob_slider.value = Global.player_settings.bob_amp


func _on_save_button_pressed():
	Global.player_settings.save()
	button_container.visible = true
	settings_panel.visible = false


func _on_settings_button_pressed():
	button_container.visible = false
	settings_panel.visible = true


func _on_quit_button_pressed():
	terrain.save_modified_blocks()
	
	get_tree().quit()


func _on_sens_slider_value_changed(value):
	Global.player_settings.sens = value


func _on_bob_slider_value_changed(value):
	Global.player_settings.bob_amp = value


func _on_cancel_button_pressed():
	button_container.visible = true
	settings_panel.visible = false
