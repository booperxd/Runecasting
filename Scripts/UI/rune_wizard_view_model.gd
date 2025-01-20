class_name RuneWizardViewModel

extends Camera3D

@onready var left_arm_player : AnimationPlayer = $Skeleton3D/LeftArmPlayer
@onready var right_arm_player : AnimationPlayer = $Skeleton3D/RightArmPlayer

@onready var rune_attachment : BoneAttachment3D = $Skeleton3D/RuneAttachment
var floating_rune_icon : PackedScene = load("res://Scenes/UI/floating_rune_element.tscn")

func _ready():
	Global.spell_casted.connect(_on_cast_spell)
	Global.rune_casted.connect(_on_rune_casted)
	right_arm_player.play("idle")


func _on_rune_casted(rune : Rune):
	var instance : FloatingRuneIcon = floating_rune_icon.instantiate() as FloatingRuneIcon
	instance.rune = rune
	rune_attachment.add_child(instance)

func _on_cast_spell():
	right_arm_player.play("cast_spell")
	



func _on_right_arm_player_animation_finished(anim_name):
	if anim_name == "cast_spell":
		right_arm_player.play("idle")
