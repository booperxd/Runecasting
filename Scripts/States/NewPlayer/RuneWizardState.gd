class_name RuneWizardState

extends State

var p : RuneWizard

func _ready():
	await(owner.ready)
	p = owner as RuneWizard
