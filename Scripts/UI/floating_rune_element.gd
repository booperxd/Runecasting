class_name FloatingRuneIcon

extends Sprite3D

var rune : Rune

func _ready():
	texture = rune.rune_icon

func _on_animation_player_animation_finished(anim_name):
	queue_free()
