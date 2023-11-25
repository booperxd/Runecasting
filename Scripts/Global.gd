extends Node

signal current_star(position)

signal stack_changed(stack)


func check_if_all_dups(array : Array):
	var dict : Dictionary
	for i in range(0, array.size()):
		dict[array[i]] = null
	if dict.size() == 1:
		return true
	return false
