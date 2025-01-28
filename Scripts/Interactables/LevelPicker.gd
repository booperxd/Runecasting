extends Interactable

@export var level : PackedScene

var can_teleport : bool = false

func _process(delta):
	if Input.is_action_just_pressed("interact") and can_teleport and level != null:
		var scene = PackedScene.new()
		scene.pack(get_tree().current_scene)
		Global.player.player_spells.save()
		Global.save_data.save(get_tree().get_current_scene())
		Global.previous_scene = scene
		get_tree().change_scene_to_packed(level)

func on_interact_hit():
	can_teleport = true
		

func on_interact_leave():
	can_teleport = false
