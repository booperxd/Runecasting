extends HealthComponent

@export var regen_amount : float = 0.05

@onready var regen_timer : Timer = $RegenTimer

var death_camera : PackedScene = load("res://Scenes/UI/death_camera.tscn")

func _ready():
	#health = max_health if Global.save_data.player_health == 0 else Global.save_data.player_health
	Global.rune_casted.connect(on_rune_casted)
	health = max_health
	
func take_damage(attack : Attack):
	health -= attack.damage
	regen_timer.start()
	Global.set_player_health.emit(health, max_health)
	Global.save_data.player_health = health
	if health <= 0:
		die()

func heal(gained_hp):
	health += gained_hp
	if health > max_health:
		health = max_health
		
	Global.set_player_health.emit(health, max_health)
	Global.save_data.player_health = health

func _on_player_ui_ready():
	Global.set_player_health.emit(health, max_health)

func on_rune_casted(rune : Rune):
	var rune_cost : Attack = Attack.new(2)
	take_damage(rune_cost)
	

func _physics_process(delta):
	if regen_timer.is_stopped() and health < max_health:
		health += regen_amount
		Global.set_player_health.emit(health, max_health)

func die():
	var position = owner.position
	var instance = death_camera.instantiate()	
	Global.current_scene.add_child(instance)
	instance.position = position + Vector3(0, 4, 4)
	instance.look_at(self.position)
	owner.queue_free()
	Input.mouse_mode=Input.MOUSE_MODE_VISIBLE
	
