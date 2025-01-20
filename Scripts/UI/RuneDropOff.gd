extends TextureRect

@onready var spell_icon : TextureRect = $SpellIcon

var rune : Rune
@export var page : int

func _can_drop_data(at_position, data):
	if rune == null:
		return true
	if data is Rune:
		if rune.rune_name == data.rune_name:
			return false
	return true
		
func _drop_data(at_position, data):
	if data is Rune:
		rune = data
		spell_icon.texture = rune.rune_icon
		Global.rune_changed.emit(rune, page)
