extends Control

@onready var button_container : VBoxContainer = $ButtonContainer
@onready var settings_panel : PanelContainer = $Panel

@onready var load_button : Button = $ButtonContainer/LoadGameButton

@onready var sens_slider : HSlider = $Panel/SettingsContainer/SensitivityContainer/SensSlider
@onready var bob_slider : HSlider = $Panel/SettingsContainer/BobAmpContainer/BobSlider


func _ready():
	button_container.visible = true
	settings_panel.visible = false
	sens_slider.value = Global.player_settings.sens
	bob_slider.value = Global.player_settings.bob_amp
	if Global.save_data.last_scene == null:
		load_button.disabled = true
	


func _on_quit_button_pressed():
	get_tree().quit()


func _on_settings_button_pressed():
	button_container.visible = false
	settings_panel.visible = true


func _on_cancel_button_pressed():
	button_container.visible = true
	settings_panel.visible = false


func _on_save_button_pressed():
	Global.player_settings.save()
	
	button_container.visible = true
	settings_panel.visible = false


func _on_sens_slider_value_changed(value):
	Global.player_settings.sens = value


func _on_bob_slider_value_changed(value):
	Global.player_settings.bob_amp = value


func _on_load_game_button_pressed():
	if Global.save_data.last_scene == null:
		return
	get_tree().change_scene_to_packed(Global.save_data.last_scene)
	

func _on_new_game_button_pressed():
	var first_level : PackedScene = load("res://Scenes/Levels/test_dungeon.tscn")
	get_tree().change_scene_to_packed(first_level)


func _on_clear_data_button_pressed():
	Global.save_data = SaveData.delete()
	if Global.save_data.last_scene == null:
		load_button.disabled = true
