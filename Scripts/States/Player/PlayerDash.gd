class_name PlayerDash

extends PlayerState

@onready var dash_timer = $DashTimer

func enter():
	Global.set_player_stamina.emit(p.stamina)
	p.input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (p.head.transform.basis * Vector3(p.input_dir.x, 0, p.input_dir.y)).normalized()	
	p.velocity.y = 0
	p.velocity.x = p.HORIZONTAL_ACCELERATION * direction.x
	p.velocity.z = p.HORIZONTAL_ACCELERATION * direction.z
	dash_timer.start()

func update(delta):
	p.velocity.y = 0


func _on_dash_timer_timeout():
	sm.transition("PlayerIdle")
