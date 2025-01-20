class_name StateMachine

extends Node

var previous_state : State
var cur_state : State
@export var initial_state : State
var parent

func _ready():
	state_init()

func state_init():
	for child in get_children():
		child.sm = self
	cur_state = initial_state
	cur_state.enter()
	
func _physics_process(delta):
	cur_state.update(delta)
	
func transition(state_name):
	if not has_node(state_name):
		pass
	previous_state = cur_state;
	cur_state.exit()
	cur_state = get_node(state_name)
	cur_state.enter()
	
	#Add signal emit
