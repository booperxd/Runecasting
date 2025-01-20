class_name PlayerState

extends State

var p : Player

func _ready():
	await(owner.ready)
	p = owner as Player
