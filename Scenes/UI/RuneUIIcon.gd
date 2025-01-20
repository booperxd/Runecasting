class_name RuneIcon

extends TextureRect

var rune : Rune
var is_draggable : bool = false

func setup_icon(_rune : Rune):
	texture = _rune.rune_icon
	rune = _rune;

func _get_drag_data(at_position):
	if !is_draggable:
		return null
	var prev_text = TextureRect.new()
	prev_text.texture = texture
	set_drag_preview(prev_text)
	return rune
