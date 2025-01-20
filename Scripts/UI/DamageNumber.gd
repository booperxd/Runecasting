class_name DamageNumber

extends Label3D


func _ready():
	billboard = BaseMaterial3D.BILLBOARD_ENABLED


func _on_timer_timeout():
	queue_free()
