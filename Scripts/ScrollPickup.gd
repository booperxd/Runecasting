extends Node3D

@export var spell_script : Script

func _process(delta):
	rotate(Vector3(0,1,0), .03)


func _on_area_3d_body_entered(body):
	if body.is_in_group("player"):
		var spell = spell_script.new() as Spell
		Global.player_spells.learn_spell(spell)
		Global.open_toast.emit('Your mind expands with the knowledge of ' + spell.spell_name)
		queue_free()
