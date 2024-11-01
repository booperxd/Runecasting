extends HealthComponent

var death_camera : PackedScene = load("res://Scenes/UI/death_camera.tscn")

func _ready():
	health = max_health if Global.save_data.player_health == 0 else Global.save_data.player_health

func take_damage(attack : Attack):
	health -= attack.damage
	Global.set_player_health.emit(health, max_health)
	Global.save_data.player_health = health
	if health <= 0:
		die()

func _on_player_ui_ready():
	Global.set_player_health.emit(health, max_health)

func die():
	var position = owner.position
	var instance = death_camera.instantiate()	
	Global.current_scene.add_child(instance)
	instance.position = position + Vector3(0, 4, 4)
	instance.look_at(self.position)
	owner.queue_free()
	Input.mouse_mode=Input.MOUSE_MODE_VISIBLE
	
