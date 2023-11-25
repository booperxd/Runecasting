extends TextureRect

@onready var hitbox = $Area2D

func _ready():
	hitbox.mouse_exited.connect(_on_area_2d_mouse_exit)


func _on_area_2d_mouse_entered():
	Global.current_star.emit(self.get_global_position())

func _on_area_2d_mouse_exit():
	Global.current_star.emit(Vector2.ZERO)
